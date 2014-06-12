//
//  RZDebugMenuSharedManager.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSharedManager.h"

@implementation RZDebugMenuSharedManager

+ (RZDebugMenuSharedManager *)sharedWindow
{
    static RZDebugMenuSharedManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedManager == nil) {
            sharedManager = [[RZDebugMenuSharedManager alloc] init];
        }
    });
    return sharedManager;
}

@end
