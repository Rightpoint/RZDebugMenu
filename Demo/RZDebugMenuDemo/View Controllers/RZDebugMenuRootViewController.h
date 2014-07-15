//
//  RZDebugMenuRootViewController.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuRootViewController : UIViewController

@property (strong, nonatomic) UIButton *tester;
@property (strong, nonatomic) UIView *circle;
@property (strong, nonatomic) UITextField *testTextField;
- (void)goToNext;

@end
