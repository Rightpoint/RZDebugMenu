//
//  RZDebugMenuRootViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuRootViewController.h"
#import "RZDebugMenuModalViewController.h"

@interface RZDebugMenuRootViewController ()

@end

@implementation RZDebugMenuRootViewController

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
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(displayDebugMenu)];
    doubleTap.numberOfTapsRequired = 3;
    doubleTap.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:doubleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Display menu methods

- (void)displayDebugMenu
{
    
    RZDebugMenuModalViewController *debugTableViewController = [[RZDebugMenuModalViewController alloc] init];
    UINavigationController *navigationWrapperController = [[UINavigationController alloc] initWithRootViewController:debugTableViewController];
    [self presentViewController:navigationWrapperController animated:YES completion:nil];
}

#pragma mark - table view delegate methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger *)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"Environment";
        cell.detailTextLabel.text = @"Placeholder";
    }
    else if (indexPath.row == 1) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *applySettingsSwitch = [[UISwitch alloc] init];
        cell.accessoryView = [[UIView alloc] initWithFrame:applySettingsSwitch.frame];
        [cell.accessoryView addSubview:applySettingsSwitch];
        cell.textLabel.text = @"Apply Changes on Reset";
    }
    else {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"Version";
        cell.detailTextLabel.text = @"0.0.1";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    // TODO: Present view with list of environments they have
}

@end
