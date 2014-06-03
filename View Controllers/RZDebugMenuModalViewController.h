//
//  RZDebugMenuModalViewController.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZDebugMenuModalViewController : UIViewController

@property(nonatomic, retain) UITableView *options;

- (void)closeView;
- (void)addEnvironment;

@end
