//
//  RZDebugMenuSliderItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuSliderItem : RZDebugMenuSettingsItem

@property (strong, nonatomic, readonly) NSNumber *max;
@property (strong, nonatomic, readonly) NSNumber *min;

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title maxValue:(NSNumber *)max minValue:(NSNumber *)min;

@end
