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

        if ( formFieldType ) {
            mutableFieldDictionary[FXFormFieldType] = formFieldType;
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
