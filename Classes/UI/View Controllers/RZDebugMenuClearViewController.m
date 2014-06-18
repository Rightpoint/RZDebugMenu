//
//  RZDebugMenuClearViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/17/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

@interface RZDebugMenuClearViewController ()

@end

@implementation RZDebugMenuClearViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void)changeGestureDirection:(UISwipeGestureRecognizer *)swipeUpGesture
{
    UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if ( statusBarOrientation == UIDeviceOrientationLandscapeLeft ) {
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    else if ( statusBarOrientation == UIDeviceOrientationLandscapeRight ) {
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    }
    else {
        swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    }
}

@end
