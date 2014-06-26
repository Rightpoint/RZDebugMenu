//
//  RZDebugMenuVersionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//
// NOTE: This class is READONLY and can not be altered via any interfaces

#import "RZDebugMenuVersionItem.h"

@interface RZDebugMenuVersionItem ()

@property (strong, nonatomic, readwrite) NSString *versionNumber;

@end

@implementation RZDebugMenuVersionItem

- (id)initWithTitle:(NSString *)title andVersionNumber:(NSString *)version
{
    self = [super initWithValue:nil forKey:nil withTitle:title];
    if ( self ) {
        _versionNumber = version;
    }
    return self;
}

@end
