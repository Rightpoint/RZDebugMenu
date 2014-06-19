//
//  RZClearViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

#import "RZDebugMenu.h"

@interface RZDebugMenuClearViewController ()

@property (strong, nonatomic) UIButton *displayDebugMenuButton;

@end

@implementation RZDebugMenuClearViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        
        _displayDebugMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 37, 37)];
        [_displayDebugMenuButton setImage:[UIImage imageNamed:@"greg.jpeg"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

@end
