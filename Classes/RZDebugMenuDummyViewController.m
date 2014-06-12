//
//  RZDebugMenuDummyViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuModalViewController.h"

@interface RZDebugMenuDummyViewController ()

@property(nonatomic, strong) RZDebugMenuSettingsInterface *interface;

@end

@implementation RZDebugMenuDummyViewController

- (id)initWithInterface:(RZDebugMenuSettingsInterface *)interface
{
    self = [super init];
    if ( self ) {
        _interface = interface;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end
