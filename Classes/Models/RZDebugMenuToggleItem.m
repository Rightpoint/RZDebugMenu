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
@property (strong, nonatomic, readwrite) NSString *userDefaultsKey;

@end

@implementation RZDebugMenuToggleItem

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andKey:(NSString *)key
{
    self = [super init];
    if ( self ) {
        self.tableViewCellTitle = title;
        _toggleCellDefaultValue = value;
        _userDefaultsKey = key;
    }
    return self;
}

@end
