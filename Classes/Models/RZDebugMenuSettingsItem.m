//
//  RZDebugMenuSettingsItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsItem.h"

@implementation RZDebugMenuSettingsItem

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title
{
    self = [super init];
    if ( self ) {
        _tableViewCellTitle = title;
        _settingsKey = key;
        _settingsValue = value;
    }
    return self;
}

@end
