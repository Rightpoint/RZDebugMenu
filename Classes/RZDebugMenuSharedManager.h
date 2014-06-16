//
//  RZDebugMenuSharedManager.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuWindow.h"
#import "RZDebugMenuDummyViewController.h"

@interface RZDebugMenuSharedManager : NSObject

@property(strong, nonatomic) RZDebugMenuWindow *topWindow;
@property(strong, nonatomic) UITapGestureRecognizer *tripleTap;
@property(strong, nonatomic) RZDebugMenuDummyViewController *clearViewController;

+ (RZDebugMenuSharedManager *)sharedTopLevel;
- (void)showViewController;

@end
