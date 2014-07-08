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

@end

@implementation RZDebugMenuSliderItem

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title
{
    self = [super initWithValue:value forKey:key withTitle:title];
    if ( self ) {
        _sliderCellDefaultValue = self.settingsValue;
    }
    return self;
}

@end
