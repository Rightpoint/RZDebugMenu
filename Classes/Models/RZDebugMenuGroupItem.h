//
//  RZDebugMenuGroupItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuGroupItem : RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title children:(NSArray *)children NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSArray *children;

@end
