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
#import "RZMultiValueSelectionItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuChildPaneItem.h"

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

+ (NSArray *)multiValueOptionsArray:(NSArray *)optionTitles withValues:(NSArray *)optionValues
{
    NSMutableArray *selectionItems = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < optionTitles.count; i++) {

        NSString *title = [optionTitles objectAtIndex:i];
        NSNumber *value = [optionValues objectAtIndex:i];
        RZMultiValueSelectionItem *selectionItemMetaData = [[RZMultiValueSelectionItem alloc] initWithTitle:title defaultValue:value];
        [selectionItems addObject:selectionItemMetaData];
    }

    return [selectionItems copy];
}

+ (NSArray *)settingsMenuItemsFromSettingsDictionary:(NSDictionary *)settingsDictionary error:(NSError * __autoreleasing *)outError
{
    NSMutableArray *mutableSettingsMenuItemsToReturn = [NSMutableArray array];
    NSError *errorToReturn = nil;

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
                id defaultvalue = [preferenceSpecifierDictionary objectForKey:kRZKeyDefaultValue];

                RZDebugMenuItem *menuItem = nil;

                if ( [itemType isEqualToString:kRZTextFieldSpecifier] ) {
                    menuItem = [[RZDebugMenuTextFieldItem alloc] initWithValue:defaultvalue key:itemIdentifier title:title];
                }
                else if ( [itemType isEqualToString:kRZSliderSpecifier] ) {
                    NSNumber *maximum = [preferenceSpecifierDictionary objectForKey:kRZKeyMaximumValue];
                    NSNumber *minimum = [preferenceSpecifierDictionary objectForKey:kRZKeyMinimumValue];
                    menuItem = [[RZDebugMenuSliderItem alloc] initWithValue:defaultvalue
                                                                        key:itemIdentifier
                                                                      title:title
                                                                   maxValue:maximum
                                                                   minValue:minimum];
                }
                else if ( [itemType isEqualToString:kRZToggleSwitchSpecifier] ) {
                    menuItem = [[RZDebugMenuToggleItem alloc] initWithValue:defaultvalue key:itemIdentifier title:title];
                }
                else if ( [itemType isEqualToString:kRZMultiValueSpecifier] ) {
                    NSArray *optionTitles = [preferenceSpecifierDictionary objectForKey:kRZKeyEnvironmentsTitles];
                    NSArray *optionValues = [preferenceSpecifierDictionary objectForKey:kRZKeyEnvironmentsValues];

                    NSArray *selectionItems = [self multiValueOptionsArray:optionTitles withValues:optionValues];

                    menuItem = [[RZDebugMenuMultiValueItem alloc] initWithValue:defaultvalue
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
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return [mutableSettingsMenuItemsToReturn copy];
}

@end
