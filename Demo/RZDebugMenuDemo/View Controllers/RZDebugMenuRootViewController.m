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
    self.view.backgroundColor = [UIColor blueColor];
}

#pragma mark - Display menu methods

//- (void)displayDebugMenu
//{
//    RZDebugMenuModalViewController *debugTableViewController = [[RZDebugMenuModalViewController alloc] initWithInterface:self.debugSettingsInterface];
//    UINavigationController *navigationControllerWrapper = [[UINavigationController alloc] initWithRootViewController:debugTableViewController];
//
//    [self presentViewController:navigationControllerWrapper animated:YES completion:nil];
//}

@end
