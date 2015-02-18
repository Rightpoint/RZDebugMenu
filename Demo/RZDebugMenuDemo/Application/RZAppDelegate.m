//
//  RZAppDelegate.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZAppDelegate.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuRootViewController.h"

static NSString *const kSettingsPlistName = @"Settings.plist";

@implementation RZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
#if (DEBUG)
    [RZDebugMenu enableMenuWithSettingsPlistName:kSettingsPlistName];
#endif
    
    RZDebugMenuRootViewController *rootViewController = [[RZDebugMenuRootViewController alloc] init];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
