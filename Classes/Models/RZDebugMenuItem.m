//
//  RZDebugMenuSettingsItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@implementation RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if ( self ) {
        _title = title;
    }

    return self;
}

@end
