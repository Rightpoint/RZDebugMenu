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

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title
{
    self = [super initWithValue:value forKey:key withTitle:title];
    if ( self ) {
        _toggleCellDefaultValue = self.settingsValue;
    }
    return self;
}

@end
