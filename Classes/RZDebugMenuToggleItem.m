//
//  RZDebugMenuToggleItem.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuToggleItem.h"

@implementation RZDebugMenuToggleItem

- (id)initWithTitle:(NSString *)title andValue:(BOOL)value
{
    self = [super init];
    if ( self ) {
        _toggleCellTitle = title;
        _toggleCellDefaultValue = value;

    }
    return self;
}

@end
