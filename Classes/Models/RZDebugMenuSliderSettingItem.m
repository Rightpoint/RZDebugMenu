//
//  RZDebugMenuSliderSettingItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSliderSettingItem.h"

#import <FXForms/FXForms.h>

@interface RZDebugMenuSliderSettingItem ()

@property (strong, nonatomic, readwrite) NSNumber *sliderCellDefaultValue;
@property (strong, nonatomic, readwrite) NSNumber *max;
@property (strong, nonatomic, readwrite) NSNumber *min;

@end

@implementation RZDebugMenuSliderSettingItem

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title maxValue:(NSNumber *)max minValue:(NSNumber *)min
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        _sliderCellDefaultValue = self.value;
        _max = max ?: @(1);
        _min = min ?: @(0);
    }
    
    return self;
}

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    return [self initWithValue:value key:key title:title maxValue:nil minValue:nil];
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeFloat;

    mutableFieldDictionary[FXFormFieldCell] = NSStringFromClass([FXFormSliderCell class]);

    NSArray *sliderMinimumKeyComponents = @[ NSStringFromSelector(@selector(slider)), NSStringFromSelector(@selector(minimumValue)) ];
    NSString *sliderMinimumValueKey = [sliderMinimumKeyComponents componentsJoinedByString:@"."];
    mutableFieldDictionary[sliderMinimumValueKey] = self.min;

    NSArray *sliderMaximumKeyComponents = @[ NSStringFromSelector(@selector(slider)), NSStringFromSelector(@selector(maximumValue)) ];
    NSString *sliderMaximumValueKey = [sliderMaximumKeyComponents componentsJoinedByString:@"."];
    mutableFieldDictionary[sliderMaximumValueKey] = self.max;

    return [mutableFieldDictionary copy];
}

@end
