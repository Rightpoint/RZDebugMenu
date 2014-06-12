//
//  RZDebugMenuDummyViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuSettingsInterface.h"
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
    self.view.backgroundColor = [UIColor redColor];
}

- (void)showViewController
{
    UIApplication *application = [UIApplication sharedApplication];
    NSArray *applicationWindows = application.windows;
    
    RZDebugMenuModalViewController *settingsMenu = [[RZDebugMenuModalViewController alloc] initWithInterface:self.interface];
    [self presentViewController:settingsMenu animated:YES completion:nil];
}

@end
