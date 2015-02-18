//
//  RZDebugMenuSettingsItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsItem.h"

@implementation RZDebugMenuSettingsItem

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super init];
    if ( self ) {
        _title = title;
        _key = key;
        _value = value;
    }

    return self;
}

@end
