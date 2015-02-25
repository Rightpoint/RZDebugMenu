//
//  RZDebugMenuSettingsParser.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsParser.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuItem.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuChildPaneItem.h"
#import "RZDebugMenuLoadedChildPaneItem.h"
#import "RZDebugMenuMultiValueSelectionItem.h"

static NSString* const kRZSettingsFileExtension = @"plist";

static NSString* const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString* const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString* const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";
static NSString* const kRZTextFieldSpecifier = @"PSTextFieldSpecifier";
static NSString* const kRZSliderSpecifier = @"PSSliderSpecifier";
static NSString* const kRZGroupSpecifer = @"PSGroupSpecifier";
static NSString* const kRZChildPaneSpecifer = @"PSChildPaneSpecifier";

static NSString* const kRZKeyBundleVersionString = @"CFBundleShortVersionString";

static NSString* const kRZKeyItemIdentifier = @"Key";
static NSString* const kRZKeyTitle = @"Title";
static NSString* const kRZKeyType = @"Type";
static NSString* const kRZKeyFile = @"File";
static NSString* const kRZKeyDefaultValue = @"DefaultValue";
static NSString* const kRZKeyEnvironmentsTitles = @"Titles";
static NSString* const kRZKeyEnvironmentsValues = @"Values";
static NSString* const kRZKeyMaximumValue = @"MaximumValue";
static NSString* const kRZKeyMinimumValue = @"MinimumValue";

@implementation RZDebugMenuSettingsParser

# pragma mark - Plist Dictionary Parsing

+ (NSArray *)multiValueOptionsArray:(NSArray *)optionTitles withValues:(NSArray *)optionValues
{
    NSMutableArray *selectionItems = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < optionTitles.count; i++) {

        NSString *title = [optionTitles objectAtIndex:i];
        NSNumber *value = [optionValues objectAtIndex:i];
        RZDebugMenuMultiValueSelectionItem *selectionItemMetaData = [[RZDebugMenuMultiValueSelectionItem alloc] initWithTitle:title value:value];
        [selectionItems addObject:selectionItemMetaData];
    }

    return [selectionItems copy];
}

+ (NSArray *)settingsMenuItemsFromSettingsDictionary:(NSDictionary *)settingsDictionary
                                       returningKeys:(NSArray * __autoreleasing *)outKeys
                                       defaultValues:(NSDictionary * __autoreleasing *)outDefaultValues
                                               error:(NSError * __autoreleasing *)outError;
{
    NSMutableArray *mutableSettingsMenuItemsToReturn = [NSMutableArray array];
    NSError *errorToReturn = nil;
    NSMutableDictionary *mutableDefaultValues = nil;
    NSMutableArray *mutableKeys = nil;

    NSArray *preferencesSpecifiers = [settingsDictionary objectForKey:kRZPreferenceSpecifiersKey];
    if ( preferencesSpecifiers ) {
        NSAssert([preferencesSpecifiers isKindOfClass:[NSArray class]], @"");
        if ( preferencesSpecifiers.count > 0 ) {
            NSDictionary *currentGroupSpecifier = nil;
            NSMutableArray *currentGroupChildren = nil;

            for ( NSDictionary *preferenceSpecifierDictionary in preferencesSpecifiers ) {
                NSString *title = [preferenceSpecifierDictionary objectForKey:kRZKeyTitle];
                NSString *itemType = [preferenceSpecifierDictionary objectForKey:kRZKeyType];
                NSString *itemIdentifier = [preferenceSpecifierDictionary objectForKey:kRZKeyItemIdentifier];
                id defaultValue = [preferenceSpecifierDictionary objectForKey:kRZKeyDefaultValue];

                RZDebugMenuItem *menuItem = nil;

                if ( [itemType isEqualToString:kRZTextFieldSpecifier] ) {
                    menuItem = [[RZDebugMenuTextFieldItem alloc] initWithValue:defaultValue key:itemIdentifier title:title];
                }
                else if ( [itemType isEqualToString:kRZSliderSpecifier] ) {
                    NSNumber *maximum = [preferenceSpecifierDictionary objectForKey:kRZKeyMaximumValue];
                    NSNumber *minimum = [preferenceSpecifierDictionary objectForKey:kRZKeyMinimumValue];
                    menuItem = [[RZDebugMenuSliderItem alloc] initWithValue:defaultValue
                                                                        key:itemIdentifier
                                                                      title:title
                                                                   maxValue:maximum
                                                                   minValue:minimum];
                }
                else if ( [itemType isEqualToString:kRZToggleSwitchSpecifier] ) {
                    menuItem = [[RZDebugMenuToggleItem alloc] initWithValue:defaultValue key:itemIdentifier title:title];
                }
                else if ( [itemType isEqualToString:kRZMultiValueSpecifier] ) {
                    NSArray *optionTitles = [preferenceSpecifierDictionary objectForKey:kRZKeyEnvironmentsTitles];
                    NSArray *optionValues = [preferenceSpecifierDictionary objectForKey:kRZKeyEnvironmentsValues];

                    NSArray *selectionItems = [self multiValueOptionsArray:optionTitles withValues:optionValues];

                    menuItem = [[RZDebugMenuMultiValueItem alloc] initWithValue:defaultValue
                                                                            key:itemIdentifier
                                                                          title:title
                                                                 selectionItems:selectionItems];
                }
                else if ( [itemType isEqualToString:kRZGroupSpecifer] ) {
                    if ( currentGroupSpecifier != nil ) {

                        NSString *title = [currentGroupSpecifier objectForKey:kRZKeyTitle];
                        RZDebugMenuItem *groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:title children:currentGroupChildren];

                        [mutableSettingsMenuItemsToReturn addObject:groupItem];

                        currentGroupChildren = nil;
                    }

                    currentGroupSpecifier = preferenceSpecifierDictionary;
                }
                else if ( [itemType isEqualToString:kRZChildPaneSpecifer] ) {
                    NSString *plistName = [preferenceSpecifierDictionary objectForKey:kRZKeyFile];
                    menuItem = [[RZDebugMenuChildPaneItem alloc] initWithTitle:title plistName:plistName];
                }
                else {
                    // NSAssert(NO, @"");
                }

                if ( defaultValue != nil && itemIdentifier.length > 0 ) {
                    if ( mutableDefaultValues == nil ) {
                        mutableDefaultValues = [NSMutableDictionary dictionary];
                    }

                    mutableDefaultValues[itemIdentifier] = defaultValue;
                }

                if ( itemIdentifier.length > 0 ) {
                    if ( mutableKeys == nil ) {
                        mutableKeys = [NSMutableArray array];
                    }

                    [mutableKeys addObject:itemIdentifier];
                }

                if ( menuItem ) {
                    if ( currentGroupSpecifier ) {
                        if ( currentGroupChildren == nil ) {
                            currentGroupChildren = [NSMutableArray array];
                        }

                        [currentGroupChildren addObject:menuItem];
                    }
                    else {
                        [mutableSettingsMenuItemsToReturn addObject:menuItem];
                    }
                }
            }

            if ( currentGroupSpecifier ) {
                NSString *title = [currentGroupSpecifier objectForKey:kRZKeyTitle];
                RZDebugMenuItem *groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:title children:currentGroupChildren];

                [mutableSettingsMenuItemsToReturn addObject:groupItem];
            }
        }
    }

    if ( errorToReturn ) {
        mutableSettingsMenuItemsToReturn = nil;
        mutableDefaultValues = nil;
        mutableKeys = nil;
    }

    if ( outDefaultValues ) {
        *outDefaultValues = [mutableDefaultValues copy];
    }

    if ( outKeys ) {
        *outKeys = [mutableKeys copy];
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return [mutableSettingsMenuItemsToReturn copy];
}

# pragma mark - Fiel Reading and Outer Parsing

+ (NSArray *)settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:(NSArray *)settingsMenuItems
                                                                    returningKeys:(NSArray * __autoreleasing *)outKeys
                                                                    defaultValues:(NSDictionary * __autoreleasing *)outDefaultValues
                                                                            error:(NSError * __autoreleasing *)outError
{
    NSError *errorToReturn = nil;
    NSMutableArray *mutableSettingsMenuItemsToReturn = [settingsMenuItems mutableCopy];
    NSMutableArray *mutableKeys = nil;
    NSMutableDictionary *mutableDefaultValues = nil;

    for ( RZDebugMenuItem *menuItem in settingsMenuItems ) {
        NSArray *keysToAdd = nil;
        NSDictionary *defaultValuesToAdd = nil;

        if ( [menuItem isKindOfClass:[RZDebugMenuChildPaneItem class]] ) {
            NSString *plistName = ((RZDebugMenuChildPaneItem *)menuItem).plistName;

            NSError *childPaneParsingError = nil;
            NSArray *childPaneSettingsMenuItems = [[self class] settingsMenuItemsFromPlistName:plistName
                                                                                 returningKeys:&keysToAdd
                                                                                 defaultValues:&defaultValuesToAdd
                                                                                         error:&childPaneParsingError];
            if ( childPaneSettingsMenuItems ) {
                RZDebugMenuLoadedChildPaneItem *loadedChildPaneItem = [[RZDebugMenuLoadedChildPaneItem alloc] initWithTitle:menuItem.title
                                                                                                                  plistName:plistName
                                                                                                          settingsMenuItems:childPaneSettingsMenuItems];
                NSUInteger index = [mutableSettingsMenuItemsToReturn indexOfObject:menuItem];
                [mutableSettingsMenuItemsToReturn replaceObjectAtIndex:index withObject:loadedChildPaneItem];
            }
            else {
                errorToReturn = childPaneParsingError;
                break;
            }
        }
        else if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            RZDebugMenuGroupItem *groupItem = (RZDebugMenuGroupItem *)menuItem;
            NSArray *childSettingsMenuItems = groupItem.children;

            NSError *recursiveLoadingError = nil;
            childSettingsMenuItems = [self settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:childSettingsMenuItems
                                                                                                  returningKeys:&keysToAdd
                                                                                                  defaultValues:&defaultValuesToAdd
                                                                                                          error:&recursiveLoadingError];

            if ( childSettingsMenuItems ) {
                groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:groupItem.title children:childSettingsMenuItems];
                NSUInteger index = [mutableSettingsMenuItemsToReturn indexOfObject:menuItem];
                [mutableSettingsMenuItemsToReturn replaceObjectAtIndex:index withObject:groupItem];
            }
            else {
                errorToReturn = recursiveLoadingError;
                break;
            }
        }

        if ( keysToAdd ) {
            if ( mutableKeys == nil ) {
                mutableKeys = [NSMutableArray array];
            }

            [mutableKeys addObjectsFromArray:keysToAdd];
        }

        if ( defaultValuesToAdd ) {
            if ( mutableDefaultValues == nil ) {
                mutableDefaultValues = [NSMutableDictionary dictionary];
            }

            [mutableDefaultValues addEntriesFromDictionary:defaultValuesToAdd];
        }
    }

    if ( errorToReturn ) {
        mutableSettingsMenuItemsToReturn = nil;
        mutableKeys = nil;
        mutableDefaultValues = nil;
    }

    if ( outKeys ) {
        *outKeys = [mutableKeys copy];
    }

    if ( outDefaultValues ) {
        *outDefaultValues = [mutableDefaultValues copy];
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return [mutableSettingsMenuItemsToReturn copy];
}

+ (NSArray *)settingsMenuItemsFromPlistName:(NSString *)plistName
                              returningKeys:(NSArray * __autoreleasing *)outKeys
                              defaultValues:(NSDictionary * __autoreleasing *)outDefaultValues
                                      error:(NSError * __autoreleasing *)outError;
{
    plistName = [plistName stringByDeletingPathExtension];

    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:plistName withExtension:kRZSettingsFileExtension];
    if ( !plistURL ) {
        NSString *exceptionName = [plistName stringByAppendingString:@".plist doesn't exist"];
        @throw [NSException exceptionWithName:exceptionName
                                       reason:@"Make sure you have a settings plist file in the Resources directory of your application"
                                     userInfo:nil];
    }

    NSArray *settingsMenuItems = nil;
    NSError *errorToReturn = nil;
    NSArray *keys = nil;
    NSDictionary *defaultValues = nil;

    NSError *dataReadingError = nil;
    NSData *plistData = [NSData dataWithContentsOfURL:plistURL options:0 error:&dataReadingError];
    if ( plistData ) {
        NSError *dataParsingError = nil;
        NSDictionary *propertyListDictionary = [NSPropertyListSerialization propertyListWithData:plistData options:0 format:NULL error:&dataParsingError];
        if ( propertyListDictionary ) {
            NSAssert([propertyListDictionary isKindOfClass:[NSDictionary class]], @"");

            NSError *settingsMenuItemsParsingError = nil;
            settingsMenuItems = [self settingsMenuItemsFromSettingsDictionary:propertyListDictionary
                                                                returningKeys:&keys
                                                                defaultValues:&defaultValues
                                                                        error:&settingsMenuItemsParsingError];
            if ( settingsMenuItems ) {
                NSError *recursiveLoadingError = nil;

                NSArray *childKeys = nil;
                NSDictionary *childDefaultValues = nil;
                settingsMenuItems = [self settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:settingsMenuItems
                                                                                                 returningKeys:&childKeys
                                                                                                 defaultValues:&childDefaultValues
                                                                                                         error:&recursiveLoadingError];

                if ( childKeys ) {
                    if ( keys ) {
                        keys = [keys arrayByAddingObjectsFromArray:childKeys];
                    }
                    else {
                        keys = childKeys;
                    }
                }

                if ( childDefaultValues ) {
                    if ( defaultValues ) {
                        NSMutableDictionary *mutableDefaultValues = [defaultValues mutableCopy];
                        [mutableDefaultValues addEntriesFromDictionary:childDefaultValues];
                        defaultValues = [mutableDefaultValues copy];
                    }
                    else {
                        defaultValues = childDefaultValues;
                    }
                }

                if ( settingsMenuItems == nil ) {
                    errorToReturn = recursiveLoadingError;
                }
            }
            else {
                errorToReturn = settingsMenuItemsParsingError;
            }
        }
        else {
            errorToReturn = dataParsingError;
        }
    }
    else {
        errorToReturn = dataReadingError;
    }

    if ( errorToReturn ) {
        settingsMenuItems = nil;
        keys = nil;
        defaultValues = nil;
    }

    if ( outKeys ) {
        *outKeys = keys;
    }

    if ( outDefaultValues ) {
        *outDefaultValues = defaultValues;
    }

    if ( outError ) {
        *outError = errorToReturn;
    }
    
    return settingsMenuItems;
}

@end
