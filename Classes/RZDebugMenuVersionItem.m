//
//  RZDebugMenuVersionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuVersionItem.h"

@interface RZDebugMenuVersionItem ()

@property(nonatomic, readwrite, strong) NSString *versionNumber;
@end

@implementation RZDebugMenuVersionItem

- (id)initWithVersionNumber:(NSString *)version
{
    self = [super init];
    if ( self ) {
        _versionNumber = version;
    }
    return self;
}

@end
