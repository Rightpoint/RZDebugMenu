//
//  RZTestViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/16/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZTestViewController.h"

static NSString * const kRZTestViewControllerTitle = @"Tester";

@interface RZTestViewController ()

@end

@implementation RZTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = kRZTestViewControllerTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
}


@end
