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

static NSString * const kRZDefaultNavTitle = @"Deafult Title";

@interface RZDebugMenuRootViewController ()

@end

@implementation RZDebugMenuRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    
    self.title = kRZDefaultNavTitle;
    
    self.tester = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 200, 100)];
    self.tester.backgroundColor = [UIColor redColor];
    [self.tester addTarget:self action:@selector(goToNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tester];
    
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    self.testTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 100, 50)];
    self.testTextField.text = @"0";
    self.testTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:self.testTextField];
    
    [RZDebugMenu addObserver:self selector:@selector(changeBackground:) forKey:@"reset_toggle"];
    [RZDebugMenu addObserver:self selector:@selector(changeValue:) forKey:@"slider_preference_2"];
    [RZDebugMenu addObserver:self selector:@selector(changeNavTitle:) forKey:@"name_preference"];
    [RZDebugMenu addObserver:self selector:@selector(changeMultiValue:) forKey:@"environment_choice"];
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

- (void)changeValue:(NSNumber *)sliderValue
{
    self.testTextField.text = [sliderValue stringValue];
}

-(void)changeNavTitle:(NSString *)newTitle
{
    if ( newTitle ) {
        self.title = newTitle;
    }
    else {
        self.title = kRZDefaultNavTitle;
    }
}

- (void)changeMultiValue:(NSNumber *)newValue
{
    if ( [newValue intValue] == 1 ) {
        self.circle.layer.cornerRadius = 50;
        self.circle.backgroundColor = [UIColor greenColor];
        [self.view addSubview:self.circle];
    }
    else {
        [self.circle removeFromSuperview];
    }
}

@end
