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

@property(nonatomic, strong) RZDebugMenuWindow *topWindow;
@property(nonatomic, strong) UITapGestureRecognizer *tripleTap;
@property(nonatomic, strong) RZDebugMenuDummyViewController *clearViewController;

+ (RZDebugMenuSharedManager *)sharedTopLevel;

@end
