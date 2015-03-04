//
//  RZDebugMenuChildItem.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuChildItem : RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title children:(NSArray *)children NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSArray *children;

@end
