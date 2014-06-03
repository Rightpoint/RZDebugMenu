//
//  RZDebugMenuModalViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"

@interface RZDebugMenuModalViewController ()

@end


@implementation RZDebugMenuModalViewController

@synthesize options = _options;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = screen.size.width;
    CGFloat height = screen.size.height;
    _options = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    
    [[self view] addSubview:_options];
    
}

#pragma mark - table view methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
