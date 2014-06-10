//
//  RZDebugMenuSettingsItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsItem.h"

@implementation RZDebugMenuSettingsItem

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andOptions:(NSArray *)options withValues:(NSArray *)optionValues
{
    self = [super init];
    if ( self ) {
        _tableViewCellTitle = title;
    }
    return self;
};

- (id)initWithTitle:(NSString *)title andValue:(BOOL)value
{
    self = [super init];
    if ( self ) {
        _tableViewCellTitle = title;
    }
    return self;
}

- (id)initWithVersionNumber:(NSString *)version
{    
    self = [super init];
    if ( self ) {
        
    }
    return self;
}

@end
