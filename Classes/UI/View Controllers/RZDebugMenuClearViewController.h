//
//  RZClearViewController.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZDebugMenuClearViewController;
@protocol RZDebugMenuClearViewControllerDelegate <NSObject>

- (void)clearViewController:(RZDebugMenuClearViewController *)clearViewController didShowDebugMenu:(id)sender;

@end

@interface RZDebugMenuClearViewController : UIViewController

@property (weak, nonatomic) id<RZDebugMenuClearViewControllerDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

@end