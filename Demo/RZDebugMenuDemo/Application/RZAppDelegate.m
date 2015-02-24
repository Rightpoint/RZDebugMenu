//
//  RZAppDelegate.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZAppDelegate.h"

#import "RZDebugMenuRootViewController.h"

#import <RZDebugMenu/RZDebugMenu.h>
#import <RZDebugMenu/RZDebugMenuSettings.h>
#import <RZDebugMenu/RZDebugMenuUserDefaultsStore.h>

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

#if (DEBUG)
    [[RZDebugMenu sharedDebugMenu] configureAutomaticShowHideOnWindow:self.window];

    // If you want your settings to be stored directly in user defaults, overwriting values used by your app via regular defaults APIs, you can uncomment the line below.
    // [[RZDebugMenuSettings sharedSettings] setDebugSettingsStoreClass:[RZDebugMenuUserDefaultsStore class]];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChanged:) name:kRZDebugMenuSettingChangedNotification object:nil];
#endif

    return YES;
}

- (void)settingsChanged:(NSNotification *)note
{
    NSLog(@"Settings changed: %@.", note);
}

@end
