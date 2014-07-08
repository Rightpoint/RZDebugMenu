//
//  RZDebugMenuRootViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuRootViewController.h"
#import "RZTestViewController.h"

#import "RZDebugMenu.h"

@interface RZDebugMenuRootViewController ()

@end

@implementation RZDebugMenuRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.tester = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    self.tester.backgroundColor = [UIColor redColor];
    [self.tester addTarget:self action:@selector(goToNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tester];
    
    [RZDebugMenu addObserver:self selector:@selector(changeBackground:) forKey:@"reset_toggle"];
}

- (void)goToNext
{
    RZTestViewController *testerController = [[RZTestViewController alloc] init];
    [self.navigationController pushViewController:testerController animated:YES];
}

- (void)changeBackground:(NSNumber *)toggleValue
{
    if ( [toggleValue boolValue] ) {
        self.view.backgroundColor = [UIColor purpleColor];
    }
    else {
        self.view.backgroundColor = [UIColor blueColor];
    }
}

@end
