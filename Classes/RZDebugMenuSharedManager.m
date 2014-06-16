//
//  RZDebugMenuSharedManager.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSharedManager.h"
#import "RZDebugMenuModalViewController.h"

@implementation RZDebugMenuSharedManager

+ (RZDebugMenuSharedManager *)sharedTopLevel
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

- (void)showViewController
{
    RZDebugMenuModalViewController *settingsMenu = [[RZDebugMenuModalViewController alloc] initWithInterface:self.clearViewController.interface];
    UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenu];
    [self.clearViewController presentViewController:modalNavigationController animated:YES completion:nil];
}

@end
