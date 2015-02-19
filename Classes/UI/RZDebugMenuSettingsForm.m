//
//  RZDebugMenuSettingsForm.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsForm.h"

#import "RZDebugMenuItem.h"
#import "RZDebugMenuItem.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZMultiValueSelectionItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuLoadedChildPaneItem.h"
#import "RZDebugMenuSettingsInterface.h"
#import "RZDebugMenuFormViewController.h"

@interface RZDebugMenuSettingsForm ()

@property (strong, nonatomic, readwrite) NSArray *settingsModels;

@property (strong, nonatomic, readwrite) NSArray *cachedFields;

@end

@implementation RZDebugMenuSettingsForm

- (instancetype)initWithSettingsModels:(NSArray *)settingsModels
{
    self = [super init];
    if ( self ) {
        self.settingsModels = settingsModels;
    }

    return self;
}

+ (NSArray *)settingsModelsByFlatteningGroups:(NSArray *)settingsModels
{
    NSMutableArray *mutableSettingsModels = [NSMutableArray array];

    for ( RZDebugMenuItem *menuItem in settingsModels ) {
        [mutableSettingsModels addObject:menuItem];

        if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            NSArray *children = ((RZDebugMenuGroupItem *)menuItem).children;
            if ( children.count > 0 ) {
                [mutableSettingsModels addObjectsFromArray:children];
            }
        }
    }

    return [mutableSettingsModels copy];
}

- (NSArray *)uncachedFields
{
    NSMutableArray *mutableFields = nil;

    NSArray *flattenedSettingsModels = [[self class] settingsModelsByFlatteningGroups:self.settingsModels];

    RZDebugMenuGroupItem *groupToStart = nil;
    id defaultValue = nil;

    for ( RZDebugMenuItem *item in flattenedSettingsModels ) {
        NSMutableDictionary *mutableFieldDictionary = [NSMutableDictionary dictionary];

        NSString *title = item.title;
        if ( title.length == 0 ) {
            title = @"";
        }
        mutableFieldDictionary[FXFormFieldTitle] = title;

        if ( groupToStart ) {
            mutableFieldDictionary[FXFormFieldHeader] = groupToStart.title;
            groupToStart = nil;
        }


        NSString *key = nil;
        if ( [item isKindOfClass:[RZDebugMenuSettingItem class]] ) {
            key = ((RZDebugMenuSettingItem *)item).key;
        }

        if ( key ) {
            mutableFieldDictionary[FXFormFieldKey] = key;   
        }

        NSString *formFieldType = nil;
        if ( [item isKindOfClass:[RZDebugMenuTextFieldItem class]] ) {
            formFieldType = FXFormFieldTypeText;
        }
        else if ( [item isKindOfClass:[RZDebugMenuToggleItem class]] ) {
            formFieldType = FXFormFieldTypeBoolean;
        }
        else if ( [item isKindOfClass:[RZDebugMenuSliderItem class]] ) {
            formFieldType = FXFormFieldTypeFloat;

            mutableFieldDictionary[FXFormFieldCell] = NSStringFromClass([FXFormSliderCell class]);

            NSArray *sliderMinimumKeyComponents = @[ NSStringFromSelector(@selector(slider)), NSStringFromSelector(@selector(minimumValue)) ];
            NSString *sliderMinimumValueKey = [sliderMinimumKeyComponents componentsJoinedByString:@"."];
            mutableFieldDictionary[sliderMinimumValueKey] = ((RZDebugMenuSliderItem *)item).min;

            NSArray *sliderMaximumKeyComponents = @[ NSStringFromSelector(@selector(slider)), NSStringFromSelector(@selector(maximumValue)) ];
            NSString *sliderMaximumValueKey = [sliderMaximumKeyComponents componentsJoinedByString:@"."];
            mutableFieldDictionary[sliderMaximumValueKey] = ((RZDebugMenuSliderItem *)item).max;
        }
        else if ( [item isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
            NSArray *selectionItems = ((RZDebugMenuMultiValueItem *)item).selectionItems;
            NSArray *titles = [selectionItems valueForKey:NSStringFromSelector(@selector(selectionTitle))];
            NSArray *values = [selectionItems valueForKey:NSStringFromSelector(@selector(selectionValue))];

            mutableFieldDictionary[FXFormFieldOptions] = values;

            mutableFieldDictionary[FXFormFieldValueTransformer] = ^(id input) {
                NSString *valueToReturn = @"";

                if ( input != nil ) {
                    NSUInteger index = [values indexOfObject:input];

                    // The input from above that was a string can get converted to a number here, so we compare the description as well.
                    if ( index == NSNotFound ) {
                        index = [values indexOfObject:[input description]];
                    }

                    NSAssert(index < NSNotFound && index >= 0, @"");
                    valueToReturn = titles[index];
                }

                return valueToReturn;
            };

            formFieldType = FXFormFieldTypeDefault;
        }
        else if ( [item isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            groupToStart = (RZDebugMenuGroupItem *)item;
        }
        else if ( [item isKindOfClass:[RZDebugMenuLoadedChildPaneItem class]] ) {
            formFieldType = FXFormFieldTypeDefault;

            NSArray *settingsModels = ((RZDebugMenuLoadedChildPaneItem *)item).settingsModels;
            RZDebugMenuSettingsForm *childSettingsForm = [[RZDebugMenuSettingsForm alloc] initWithSettingsModels:settingsModels];
            defaultValue = childSettingsForm;

            mutableFieldDictionary[FXFormFieldClass] = [RZDebugMenuSettingsForm class];
            mutableFieldDictionary[FXFormFieldViewController] = [[RZDebugMenuFormViewController alloc] init];
        }

        if ( [item isKindOfClass:[RZDebugMenuSettingItem class]] ) {
            defaultValue = ((RZDebugMenuSettingItem *)item).value;
        }

        if ( defaultValue ) {
            mutableFieldDictionary[FXFormFieldDefaultValue] = defaultValue;
        }

        if ( formFieldType ) {
            mutableFieldDictionary[FXFormFieldType] = formFieldType;

            if ( mutableFields == nil ) {
                mutableFields = [NSMutableArray array];
            }

            [mutableFields addObject:[mutableFieldDictionary copy]];
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
            else if ( [menuItem isKindOfClass:[RZDebugMenuLoadedChildPaneItem class]] ) {
                NSArray *childMenuItems = ((RZDebugMenuLoadedChildPaneItem *)menuItem).settingsModels;
                settingsMenuItem = [[self class] settingsMenuItemForKey:key inMenuItems:childMenuItems];
            }
        }
    }

    return settingsMenuItem;
}

- (RZDebugMenuSettingItem *)settingsMenuItemForKey:(NSString *)key
{
    return [[self class] settingsMenuItemForKey:key inMenuItems:self.settingsModels];
}

- (id)valueForKey:(NSString *)key
{
    id valueToReturn = nil;

    RZDebugMenuSettingItem *settingsItem = [self settingsMenuItemForKey:key];
    if ( settingsItem ) {
        valueToReturn = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:key];
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
        [RZDebugMenuSettingsInterface setValue:value forDebugSettingsKey:key];
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
