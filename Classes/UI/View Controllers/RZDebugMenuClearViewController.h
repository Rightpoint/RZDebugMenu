//
//  RZClearViewController.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@class RZDebugMenuClearViewController;

@protocol RZDebugMenuClearViewControllerDelegate <NSObject>

- (void)clearViewControllerDebugMenuButtonPressed:(RZDebugMenuClearViewController *)clearViewController;

@end

@interface RZDebugMenuClearViewController : UIViewController

- (id)initWithDelegate:(id)delegate;

@property (assign, nonatomic, readwrite) BOOL showDebugMenuButton;

@end
