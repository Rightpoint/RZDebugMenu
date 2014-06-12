//
//  RZDebugMenuDummyViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuDummyViewController.h"

@interface RZDebugMenuDummyViewController ()

@end

@implementation RZDebugMenuDummyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showViewController
{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *applicationWindows = application.windows;
    UIWindow *debugMenuWindow = [applicationWindows lastObject];
    debugMenuWindow.windowLevel = UIWindowLevelAlert;
    //    [self presentViewController:debugMenuWindow.rootViewController animated:YES completion:nil];
}

@end
