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
#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuSettingsInterface.h"

@implementation RZAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    RZDebugMenuRootViewController *rootViewController = [[RZDebugMenuRootViewController alloc] init];
//    rootViewController.debugSettingsInterface = debugSettingsInterface;
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootViewController;
    
#if (DEBUG)
    //    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    //    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //    RZDebugMenuSettingsInterface *debugSettingsInterface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
    
    [RZDebugMenu enable];
#endif
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
