//
//  RZDebugMenuSettingsForm.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsForm.h"

#import "RZDebugMenuItem.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuLoadedChildPaneItem.h"
#import "RZDebugMenuSettings.h"
#import "RZDebugMenuFormViewController.h"
#import "RZDebugMenuTitleItem.h"
#import "RZDebugMenuMultiValueSelectionItem.h"
#import "RZDebugMenuVersionItem.h"

#import "RZDebugMenuShortTitles.h"

@interface RZDebugMenuSettingsForm ()

@property (strong, nonatomic, readwrite) NSArray *settingsMenuItems;

@property (strong, nonatomic, readwrite) NSArray *cachedFields;

@end

@implementation RZDebugMenuSettingsForm

- (instancetype)initWithSettingsMenuItems:(NSArray *)settingsMenuItems
{
    self = [super init];
    if ( self ) {
        self.settingsMenuItems = settingsMenuItems;
    }

    return self;
}

+ (NSArray *)settingsMenuItemsByFlatteningGroupsFromSettingsMenuItems:(NSArray *)settingsMenuItems
{
    NSMutableArray *mutableSettingsMenuItems = [NSMutableArray array];

    for ( RZDebugMenuItem *menuItem in settingsMenuItems ) {
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
    NSMutableArray *mutableFields = nil;

    NSArray *flattenedSettingsMenuItems = [[self class] settingsMenuItemsByFlatteningGroupsFromSettingsMenuItems:self.settingsMenuItems];

    RZDebugMenuGroupItem *groupToStart = nil;
    id defaultValue = nil;

    for ( RZDebugMenuItem *item in flattenedSettingsMenuItems ) {
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
            NSArray *longTitles = [selectionItems valueForKey:NSStringFromSelector(@selector(title))];
            NSArray *values = [selectionItems valueForKey:NSStringFromSelector(@selector(value))];
            NSArray *shortTitles = [selectionItems valueForKey:NSStringFromSelector(@selector(shortTitle))];

            BOOL hasShortTitles = [[shortTitles firstObject] isKindOfClass:[NSString class]];

            mutableFieldDictionary[FXFormFieldOptions] = values;

            NSArray *titlesForTransform = longTitles;

            if ( hasShortTitles ) {
                mutableFieldDictionary[FXFormFieldViewController] = [[RZFormLongNameViewController alloc] initWithLongTitles:longTitles];
                titlesForTransform = shortTitles;
            }

            mutableFieldDictionary[FXFormFieldValueTransformer] = ^(id input) {
                NSString *valueToReturn = @"";

                if ( input != nil ) {
                    NSUInteger index = [values indexOfObject:input];
                    NSAssert(index < NSNotFound && index >= 0, @"");
                    valueToReturn = titlesForTransform[index];
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

            NSArray *settingsMenuItems = ((RZDebugMenuLoadedChildPaneItem *)item).settingsMenuItems;
            RZDebugMenuSettingsForm *childSettingsForm = [[RZDebugMenuSettingsForm alloc] initWithSettingsMenuItems:settingsMenuItems];
            defaultValue = childSettingsForm;

            mutableFieldDictionary[FXFormFieldClass] = [RZDebugMenuSettingsForm class];
            mutableFieldDictionary[FXFormFieldViewController] = [[RZDebugMenuFormViewController alloc] init];
        }
        else if ( [item isKindOfClass:[RZDebugMenuTitleItem class]] ) {
            formFieldType = FXFormFieldTypeDefault;

            NSArray *values = ((RZDebugMenuTitleItem *)item).values;
            NSArray *titles = ((RZDebugMenuTitleItem *)item).titles;

            mutableFieldDictionary[FXFormFieldValueTransformer] = ^(id input) {
                NSString *valueToReturn = @"";

                if ( input != nil ) {
                    NSUInteger index = [values indexOfObject:input];
                    NSAssert(index < NSNotFound && index >= 0, @"");
                    valueToReturn = titles[index];
                }

                return valueToReturn;
            };
        }
        else if ( [item isKindOfClass:[RZDebugMenuVersionItem class]] ) {
            defaultValue = ((RZDebugMenuVersionItem *)item).versionString;
            formFieldType = FXFormFieldTypeDefault;

            mutableFieldDictionary[FXFormFieldCell] = [FXFormTextFieldCell class];

            NSArray *textKeyComponents = @[ NSStringFromSelector(@selector(textField)), NSStringFromSelector(@selector(text)) ];
            NSString *textKey = [textKeyComponents componentsJoinedByString:@"."];
            [mutableFieldDictionary setObject:defaultValue forKey:textKey];

            NSArray *textFieldEnabledKeyComponents = @[ NSStringFromSelector(@selector(textField)), @"enabled" ];
            NSString *textFieldEnabledKey = [textFieldEnabledKeyComponents componentsJoinedByString:@"."];
            [mutableFieldDictionary setObject:@(NO) forKey:textFieldEnabledKey];
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
                NSArray *childMenuItems = ((RZDebugMenuLoadedChildPaneItem *)menuItem).settingsMenuItems;
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
    return [[self class] settingsMenuItemForKey:key inMenuItems:self.settingsMenuItems];
}

- (id)valueForKey:(NSString *)key
{
    id valueToReturn = nil;

    RZDebugMenuSettingItem *settingsItem = [self settingsMenuItemForKey:key];
    if ( settingsItem ) {
        valueToReturn = [RZDebugMenuSettings sharedSettings][key];

        if ( [settingsItem isKindOfClass:[RZDebugMenuToggleItem class]] ) {
            id trueValue = ((RZDebugMenuToggleItem *)settingsItem).trueValue;
            id __attribute__((unused)) falseValue = ((RZDebugMenuToggleItem *)settingsItem).falseValue;
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
        if ( [settingsItem isKindOfClass:[RZDebugMenuToggleItem class]] ) {
            id trueValue = ((RZDebugMenuToggleItem *)settingsItem).trueValue;
            id falseValue = ((RZDebugMenuToggleItem *)settingsItem).falseValue;
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
