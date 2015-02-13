//
//  RZDebugMenuToggleItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuToggleItem.h"

@interface RZDebugMenuToggleItem ()

@property (strong, nonatomic, readwrite) NSNumber *toggleCellDefaultValue;

@end

@implementation RZDebugMenuToggleItem

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        _toggleCellDefaultValue = self.value;
    }
    
    return self;
}

@end
