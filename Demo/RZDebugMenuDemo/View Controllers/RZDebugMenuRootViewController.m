//
//  RZDebugMenuRootViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuRootViewController.h"
#import "RZDebugMenuModalViewController.h"

@interface RZDebugMenuRootViewController ()

@end

@implementation RZDebugMenuRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayDebugMenu)];
    doubleTap.numberOfTapsRequired = 3;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];

    
}

#pragma mark - Display menu methods

- (void)displayDebugMenu
{
    RZDebugMenuModalViewController *debugTableViewController = [[RZDebugMenuModalViewController alloc] initWithInterface:self.debugSettingsInterface];
    UINavigationController *navigationControllerWrapper = [[UINavigationController alloc] initWithRootViewController:debugTableViewController];

    [self presentViewController:navigationControllerWrapper animated:YES completion:nil];
}

@end
