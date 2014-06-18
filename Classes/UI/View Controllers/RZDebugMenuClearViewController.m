//
//  RZDebugMenuClearViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/17/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

@interface RZDebugMenuClearViewController ()

@end

@implementation RZDebugMenuClearViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if ( self ) {
        _delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

@end
