//
//  RZDebugMenuForm.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuForm.h"

#import "RZDebugMenuItem.h"
#import "RZDebugMenuMultiValueSettingItem.h"
#import "RZDebugMenuToggleSettingItem.h"
#import "RZDebugMenuTextSettingItem.h"
#import "RZDebugMenuSliderSettingItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuLoadedSettingsBundleChildItem.h"
#import "RZDebugMenuSettings.h"
#import "RZDebugMenuFormViewController.h"
#import "RZDebugMenuReadOnlyTextSettingItem.h"
#import "RZDebugMenuMultiValueSelectionItem.h"
#import "RZDebugMenuVersionItem.h"

#import "RZDebugMenuShortTitles.h"

@interface RZDebugMenuForm ()

@property (strong, nonatomic, readwrite) NSArray *menuItems;

@property (strong, nonatomic, readwrite) NSArray *cachedFields;

@end

@implementation RZDebugMenuForm

- (instancetype)initWithMenuItems:(NSArray *)menuItems
{
    self = [super init];
    if ( self ) {
        self.menuItems = menuItems;
    }

    return self;
}

+ (NSArray *)menuItemsByFlatteningGroupsFromMenuItems:(NSArray *)menuItems
{
    NSMutableArray *mutableSettingsMenuItems = [NSMutableArray array];

    for ( RZDebugMenuItem *menuItem in menuItems ) {
        [mutableSettingsMenuItems addObject:menuItem];

        if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            NSArray *children = ((RZDebugMenuGroupItem *)menuItem).children;
            if ( children.count > 0 ) {
                [mutableSettingsMenuItems addObjectsFromArray:children];
            }
        }
    }

    return [mutableSettingsMenuItems copy];
}

- (NSArray *)uncachedFields
{
    NSArray *flattenedMenuItems = [[self class] menuItemsByFlatteningGroupsFromMenuItems:self.menuItems];

    NSMutableArray *mutableFields = nil;

    RZDebugMenuGroupItem *groupToStart = nil;

    for ( RZDebugMenuItem *item in flattenedMenuItems ) {
        NSDictionary *fieldDictionary = item.fxFormsFieldDictionary;

        NSArray *childMenuItems = item.fxFormsChildMenuItems;
        if ( childMenuItems.count > 0 ) {
            NSMutableDictionary *mutableFieldDictionary = [fieldDictionary mutableCopy];

            RZDebugMenuForm *childSettingsForm = [[RZDebugMenuForm alloc] initWithMenuItems:childMenuItems];
            childSettingsForm.delegate = self.delegate;

            mutableFieldDictionary[FXFormFieldDefaultValue] = childSettingsForm;

            mutableFieldDictionary[FXFormFieldClass] = [RZDebugMenuForm class];

            UIViewController *formViewController = [self.delegate viewControllerForChildPaneItem:item];
            NSAssert(formViewController != nil, @"");

            mutableFieldDictionary[FXFormFieldViewController] = formViewController;

            fieldDictionary = [mutableFieldDictionary copy];
        }

        if ( groupToStart ) {
            NSAssert([item isKindOfClass:[RZDebugMenuGroupItem class]] == NO, @"Nested groups aren't allowed!");

            NSMutableDictionary *mutableFieldDictionary = [fieldDictionary mutableCopy];

            mutableFieldDictionary[FXFormFieldHeader] = groupToStart.title;

            groupToStart = nil;

            fieldDictionary = [mutableFieldDictionary copy];
        }

        if ( [item isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            groupToStart = (RZDebugMenuGroupItem *)item;
        }

        NSString *formFieldType = fieldDictionary[FXFormFieldType];

        if ( formFieldType.length > 0 ) {
            if ( mutableFields == nil ) {
                mutableFields = [NSMutableArray array];
            }

            [mutableFields addObject:fieldDictionary];
        }
    }

    return [mutableFields copy];
}

- (NSArray *)fields
{
    NSArray *cachedFields = self.cachedFields;

    if ( cachedFields == nil ) {
        cachedFields = [self uncachedFields];
        self.cachedFields = cachedFields;
    }

    return cachedFields;
}

+ (RZDebugMenuSettingItem *)settingsMenuItemForKey:(NSString *)key inMenuItems:(NSArray *)menuItems
{
    RZDebugMenuSettingItem *settingsMenuItem = nil;

    for ( RZDebugMenuItem *menuItem in menuItems ) {
        if ( [menuItem isKindOfClass:[RZDebugMenuSettingItem class]] ) {
            if ( [((RZDebugMenuSettingItem *)menuItem).key isEqualToString:key] ) {
                settingsMenuItem = (RZDebugMenuSettingItem *)menuItem;
                break;
            }
        }
        else {
            if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
                NSArray *childMenuItems = ((RZDebugMenuGroupItem *)menuItem).children;
                settingsMenuItem = [[self class] settingsMenuItemForKey:key inMenuItems:childMenuItems];
            }
            else if ( [menuItem isKindOfClass:[RZDebugMenuLoadedSettingsBundleChildItem class]] ) {
                NSArray *childMenuItems = ((RZDebugMenuLoadedSettingsBundleChildItem *)menuItem).settingsMenuItems;
                settingsMenuItem = [[self class] settingsMenuItemForKey:key inMenuItems:childMenuItems];
            }

            if ( settingsMenuItem ) {
                break;
            }
        }
    }

    return settingsMenuItem;
}

- (RZDebugMenuSettingItem *)settingsMenuItemForKey:(NSString *)key
{
    return [[self class] settingsMenuItemForKey:key inMenuItems:self.menuItems];
}

- (id)valueForKey:(NSString *)key
{
    id valueToReturn = nil;

    RZDebugMenuSettingItem *settingsItem = [self settingsMenuItemForKey:key];
    if ( settingsItem ) {
        valueToReturn = [RZDebugMenuSettings sharedSettings][key];

        if ( [settingsItem isKindOfClass:[RZDebugMenuToggleSettingItem class]] ) {
            id trueValue = ((RZDebugMenuToggleSettingItem *)settingsItem).trueValue;
            id __attribute__((unused)) falseValue = ((RZDebugMenuToggleSettingItem *)settingsItem).falseValue;
            if ( trueValue ) {
                NSAssert(falseValue != nil, @"");
                NSAssert([trueValue class] == [falseValue class], @"");

                NSNumber *(^valueTransformer)(id value) = ^(id value) {
                    NSNumber *valueToReturn = @(NO);

                    if ( [value isEqual:trueValue] ) {
                        valueToReturn = @(YES);
                    }

                    return valueToReturn;
                };

                valueToReturn = valueTransformer(valueToReturn);
            }
        }
    }
    else {
        valueToReturn = [super valueForKey:key];
    }

    return valueToReturn;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    RZDebugMenuSettingItem *settingsItem = [self settingsMenuItemForKey:key];
    if ( settingsItem ) {
        if ( [settingsItem isKindOfClass:[RZDebugMenuToggleSettingItem class]] ) {
            id trueValue = ((RZDebugMenuToggleSettingItem *)settingsItem).trueValue;
            id falseValue = ((RZDebugMenuToggleSettingItem *)settingsItem).falseValue;
            if ( trueValue ) {
                NSAssert(falseValue != nil, @"");
                NSAssert([trueValue class] == [falseValue class], @"");

                id (^reverseValueTransformer)(NSNumber *value) = ^(NSNumber *value) {
                    id valueToReturn = falseValue;

                    NSAssert([value isKindOfClass:[NSNumber class]], @"");

                    if ( [value boolValue] ) {
                        valueToReturn = trueValue;
                    }

                    return valueToReturn;
                };

                value = reverseValueTransformer(value);
            }
        }

        [RZDebugMenuSettings sharedSettings][key] = value;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
