//
//  RZDebugMenuToggleItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuToggleItem.h"

@interface RZDebugMenuToggleItem ()

@property(readwrite, assign) BOOL toggleCellDefaultValue;

@end

@implementation RZDebugMenuToggleItem

- (id)initWithTitle:(NSString *)title andValue:(BOOL)value
{
    self = [super initWithTitle:title andValue:value];
    if ( self ) {
        _toggleCellDefaultValue = value;

    }
    return self;
}

@end
