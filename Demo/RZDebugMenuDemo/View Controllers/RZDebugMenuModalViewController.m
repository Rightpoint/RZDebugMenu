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
#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"

#import "RZSettingsInterfaceTableViewCell.h"

static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

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
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(closeView)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(addEnvironment)];
    
    self.optionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = addButton;
    [self.view addSubview:_optionsTableView];
    
    UITableViewCell *toggleSwitchTableViewCell = [[RZSettingsInterfaceTableViewCell alloc] setupToggleCellWithTitle:@"RESET" andValue:YES];
    
    UITableViewCell *versionInformationTableViewCell;
    
    [self.optionsTableView registerClass:[RZSettingsInterfaceTableViewCell class] forCellReuseIdentifier:kRZDisclosureReuseIdentifier];
    [self.optionsTableView registerClass:[RZToggleTableViewCell class] forCellReuseIdentifier:kRZToggleReuseIdentifier];
    [self.optionsTableView registerClass:[RZSettingsInterfaceTableViewCell class] forCellReuseIdentifier:kRZVersionInfoReuseIdentifier];
    
    self.optionsTableView.delegate = self;
    self.optionsTableView.dataSource = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier];
    
    if ( indexPath.row == 0 ) {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZDisclosureReuseIdentifier];
    }
    else if ( indexPath.row == 1 ) {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
    }
    else {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if ( indexPath.row == 0 ) {
        
        RZDebugMenuEnvironmentsListViewController *environmentsView = [[RZDebugMenuEnvironmentsListViewController alloc] init];
        [self.navigationController pushViewController:environmentsView animated:YES];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
