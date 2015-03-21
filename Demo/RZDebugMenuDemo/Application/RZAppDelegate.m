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
    // To activate the debug menu, call this method with the name of the settings plist you want to use. It should be included in your application bundle.
    [RZDebugMenu enableMenuWithSettingsPlistName:kSettingsPlistName];
#endif
    
    RZDebugMenuRootViewController *rootViewController = [[RZDebugMenuRootViewController alloc] init];
    UINavigationController *rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = rootNavigationController;
    [self.window makeKeyAndVisible];

#if (DEBUG)
    // To configure automatic show and hide of the debug menu via a 4-tap gesture, call this method with your app's primary window.
    [[RZDebugMenu sharedDebugMenu] configureAutomaticShowHideOnWindow:self.window];

    // The debug menu button will be hidden by default. To show it, call the above method and then do the 4-tap gesture, or you can enable it programmatically as follows.
    [RZDebugMenu sharedDebugMenu].showDebugMenuButton = YES;

    // If you want your settings to be stored directly in user defaults, overwriting values used by your app via regular defaults APIs, you can uncomment the line below.
    // [[RZDebugMenuSettings sharedSettings] setDebugSettingsStoreClass:[RZDebugMenuUserDefaultsStore class]];

    // For general observation of changes to any debug settings, you can use this notification, which includes specific information on what setting changes, as well as the previous and new values.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(settingsChanged:) name:kRZDebugMenuSettingChangedNotification object:nil];
#endif

    return YES;
}

- (void)settingsChanged:(NSNotification *)note
{
    NSLog(@"Settings changed: %@.", note);
}

@end
