//
//  UIViewController+RZDebugMenuPresentationAdditions.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/2/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (RZDebugMenuPresentationAdditions)

@property (strong, nonatomic, readonly) UIViewController *rzDebugMenu_deepestPresentedViewController;
@property (strong, nonatomic, readonly) UIViewController *rzDebugMenu_deepestViewControllerForPresentation;

@end
