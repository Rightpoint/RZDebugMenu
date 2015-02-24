//
//  RZDebugMenuRootViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuRootViewController.h"

#import <RZDebugMenu/RZDebugMenu.h>
#import <RZDebugMenu/RZDebugMenuSettings.h>

@interface RZDebugMenuRootViewController ()

@end

@implementation RZDebugMenuRootViewController

- (void)dealloc
{
    [[RZDebugMenuSettings sharedSettings] removeObserver:self forKeyPath:@"reset_toggle"];
    [[RZDebugMenuSettings sharedSettings] removeObserver:self forKeyPath:@"slider_preference"];
    [[RZDebugMenuSettings sharedSettings] removeObserver:self forKeyPath:@"name_preference"];
    [[RZDebugMenuSettings sharedSettings] removeObserver:self forKeyPath:@"circle_choice"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];

    self.circle = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    
    self.testTextField = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    self.testTextField.text = @"0";
    self.testTextField.textColor = [UIColor whiteColor];
    self.testTextField.enabled = NO;
    [self.view addSubview:self.testTextField];

    [[RZDebugMenuSettings sharedSettings] addObserver:self forKeyPath:@"reset_toggle" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [[RZDebugMenuSettings sharedSettings] addObserver:self forKeyPath:@"slider_preference" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [[RZDebugMenuSettings sharedSettings] addObserver:self forKeyPath:@"name_preference" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];
    [[RZDebugMenuSettings sharedSettings] addObserver:self forKeyPath:@"circle_choice" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL];

    UIGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerFired:)];
    [self.view addGestureRecognizer:panGestureRecognizer];
}

- (void)panGestureRecognizerFired:(id)sender
{
    if ( self.presentedViewController == nil ) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Whoah there ...." message:@"You swiped the backgroud view, didn't you?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Yep" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
    self.title = newTitle;
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];

    if ( [keyPath isEqualToString:@"reset_toggle"] ) {
        [self changeBackground:newValue];
    }
    else if ( [keyPath isEqualToString:@"slider_preference"] ) {
        [self changeValue:newValue];
    }
    else if ( [keyPath isEqualToString:@"name_preference"] ) {
        [self changeNavTitle:newValue];
    }
    else if ( [keyPath isEqualToString:@"circle_choice"] ) {
        [self changeMultiValue:newValue];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
