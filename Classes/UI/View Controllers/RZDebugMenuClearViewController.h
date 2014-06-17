//
//  RZDebugMenuClearViewController.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/17/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZDebugMenuClearViewController;
@protocol RZDebugMenuClearViewControllerDelegate <NSObject>

- (void)changeOrientation:(UISwipeGestureRecognizer *)swipeGesture;

@end

@interface RZDebugMenuClearViewController : UIViewController

- (void)changeGestureOrientation:(NSNotification *)message;

@end
