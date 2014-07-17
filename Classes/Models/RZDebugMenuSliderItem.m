//
//  RZDebugMenuSliderItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSliderItem.h"

@interface RZDebugMenuSliderItem ()

@property (strong, nonatomic, readwrite) NSNumber *sliderCellDefaultValue;
@property (strong, nonatomic, readwrite) NSNumber *max;
@property (strong, nonatomic, readwrite) NSNumber *min;

@end

@implementation RZDebugMenuSliderItem

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title maxValue:(NSNumber *)max minValue:(NSNumber *)min
{
    self = [super initWithValue:value forKey:key withTitle:title];
    if ( self ) {
        _sliderCellDefaultValue = self.settingsValue;
        _max = max ?: @(1);
        _min = min ?: @(0);
    }
    return self;
}

@end
