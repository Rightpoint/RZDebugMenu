//
//  UIViewController+RZDebugMenuPresentationAdditions.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/2/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "UIViewController+RZDebugMenuPresentationAdditions.h"

@implementation UIViewController (RZDebugMenuPresentationAddition)

- (UIViewController *)rzDebugMenu_deepestPresentedViewController
{
    UIViewController *deepestPresentedViewController = nil;

    if ( self.presentedViewController ) {
        if ( self.presentedViewController.presentedViewController == nil ) {
            deepestPresentedViewController = self.presentedViewController;
        }
        else {
            deepestPresentedViewController = self.presentedViewController.rzDebugMenu_deepestPresentedViewController;
        }
    }

    return deepestPresentedViewController;
}

- (UIViewController *)rzDebugMenu_deepestViewControllerForPresentation
{
    UIViewController *viewControllerToReturn = self;

    if ( self.presentedViewController ) {
        viewControllerToReturn = self.rzDebugMenu_deepestPresentedViewController;
    }

    return viewControllerToReturn;
}

@end
