//
//  RZDebugMenuSliderItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingItem.h"

@interface RZDebugMenuSliderItem : RZDebugMenuSettingItem

@property (strong, nonatomic, readonly) NSNumber *max;
@property (strong, nonatomic, readonly) NSNumber *min;

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title maxValue:(NSNumber *)max minValue:(NSNumber *)min NS_DESIGNATED_INITIALIZER;

@end
