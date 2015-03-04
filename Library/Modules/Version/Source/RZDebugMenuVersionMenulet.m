//
//  RZDebugMenuVersionMenulet.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

static NSString *const kRZVersionTitle = @"Version";

#import "RZDebugMenuVersionMenulet.h"

#import "RZDebugMenuVersionItem.h"

@implementation RZDebugMenuVersionMenulet

- (NSString *)title
{
    return kRZVersionTitle;
}

- (NSArray *)menuItems
{
    RZDebugMenuVersionItem *versionItem = [[RZDebugMenuVersionItem alloc] init];
    return @[ versionItem ];
}

@end
