//
//  RZDebugMenuRootViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuRootViewController.h"

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
    
    self.circle = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    self.testTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    self.testTextField.text = @"0";
    self.testTextField.textColor = [UIColor whiteColor];
    self.testTextField.enabled = NO;
    [self.view addSubview:self.testTextField];
    
    [RZDebugMenu addObserver:self selector:@selector(changeBackground:) forKey:@"reset_toggle" updateImmediately:YES];
    [RZDebugMenu addObserver:self selector:@selector(changeValue:) forKey:@"slider_preference" updateImmediately:YES];
    [RZDebugMenu addObserver:self selector:@selector(changeNavTitle:) forKey:@"name_preference" updateImmediately:YES];
    [RZDebugMenu addObserver:self selector:@selector(changeMultiValue:) forKey:@"circle_choice" updateImmediately:YES];
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

- (void)changeNavTitle:(NSString *)newTitle
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
    self.circle.layer.cornerRadius = 50;
    
    switch ( [newValue intValue] ) {
        case 1: {
            self.circle.backgroundColor = [UIColor greenColor];
            [self.view addSubview:self.circle];
            break;
        }
            
        case 2: {
            self.circle.backgroundColor = [UIColor blueColor];
            [self.view addSubview:self.circle];
            break;
        }
            
        case 3: {
            self.circle.backgroundColor = [UIColor redColor];
            [self.view addSubview:self.circle];
            break;
        }
            
        default:
            [self.circle removeFromSuperview];
            break;
    }
}

@end
