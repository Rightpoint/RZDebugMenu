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

- (NSArray *)uncachedFields
{
    NSMutableArray *mutableFields = nil;

    for ( RZDebugMenuItem *item in self.settingsModels ) {
        NSMutableDictionary *mutableFieldDictionary = [NSMutableDictionary dictionary];

        NSString *title = item.title;

        if ( title.length > 0 ) {
            mutableFieldDictionary[FXFormFieldTitle] = title;
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

        if ( formFieldType ) {
            mutableFieldDictionary[FXFormFieldType] = formFieldType;
        }

        id defaultValue = nil;
        if ( [item isKindOfClass:[RZDebugMenuSettingItem class]] ) {
            defaultValue = ((RZDebugMenuSettingItem *)item).value;
        }

        if ( defaultValue ) {
            mutableFieldDictionary[FXFormFieldDefaultValue] = defaultValue;
        }

        if ( mutableFields == nil ) {
            mutableFields = [NSMutableArray array];
        }

        [mutableFields addObject:[mutableFieldDictionary copy]];
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

@end
