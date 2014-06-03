//
//  RZDebugMenuModalViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuRootViewController.h"
#import "RZDebugMenuEnvironmentsListViewController.h"
#import "RZEnvironmentsListTableViewCell.h"
#import "RZToggleResetTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"
#import "RZDebugMenu.h"

@interface RZDebugMenuModalViewController ()

@property(nonatomic, strong) UITableView *optionsTableView;
@property(nonatomic, strong) NSDictionary *settingsDictionary;

@end


@implementation RZDebugMenuModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Env Settings";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: Put this in its' own class. Singleton pattern?
    NSString *settingsPlistPath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
    [_settingsDictionary initWithContentsOfFile:settingsPlistPath];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    _optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(closeView)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(addEnvironment)];
    
    _optionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = addButton;
    [self.view addSubview:_optionsTableView];
    
    [_optionsTableView registerClass:[RZEnvironmentsListTableViewCell class] forCellReuseIdentifier:@"environments"];
    [_optionsTableView registerClass:[RZToggleResetTableViewCell class] forCellReuseIdentifier:@"toggle"];
    [_optionsTableView registerClass:[RZVersionInfoTableViewCell class] forCellReuseIdentifier:@"version"];
    
    _optionsTableView.delegate = self;
    _optionsTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - nav bar buttons methods

- (void)closeView
{
    // TODO: save plist in completion
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addEnvironment
{
    // TODO: call methods to edit plist in settings bundle
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
    UITableViewCell *cell;
    
    if ( indexPath.row == 0 ) {
        cell = [_optionsTableView dequeueReusableCellWithIdentifier:@"environments"];
    }
    else if ( indexPath.row == 1 ) {
        cell = [_optionsTableView dequeueReusableCellWithIdentifier:@"toggle"];
    }
    else {
        cell = [_optionsTableView dequeueReusableCellWithIdentifier:@"version"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ) {
        
        RZDebugMenuEnvironmentsListViewController *environmentsView = [[RZDebugMenuEnvironmentsListViewController alloc] init];
        [self.navigationController pushViewController:environmentsView animated:YES];
        [_optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
