//
//  RZDebugMenuClearViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/17/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

#import "RZDebugMenuWindow.h"

@interface RZDebugMenuClearViewController ()

@end

@implementation RZDebugMenuClearViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)changeGestureOrientation:(NSNotification *)message
{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    UIApplication *mainApplication = [UIApplication sharedApplication];
    UIWindow *mainWindow = mainApplication.keyWindow;
    
    if ( statusBarOrientation == UIDeviceOrientationLandscapeLeft ) {
        NSLog(@"Left");
    }
    else if ( statusBarOrientation == UIDeviceOrientationLandscapeRight ) {
        NSLog(@"Right");
    }
    else {
        NSLog(@"Direction up");
    }
}

@end
