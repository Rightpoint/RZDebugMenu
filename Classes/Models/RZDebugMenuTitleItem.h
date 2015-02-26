//
//  RZDebugMenuTitleItem.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/25/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingItem.h"

@interface RZDebugMenuTitleItem : RZDebugMenuSettingItem

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title values:(NSArray *)values titles:(NSArray *)titles NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSArray *values;
@property (copy, nonatomic, readonly) NSArray *titles;

@end
