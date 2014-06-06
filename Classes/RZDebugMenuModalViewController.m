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
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"

static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

@interface RZDebugMenuModalViewController ()

@property(nonatomic, strong) UITableView *optionsTableView;

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
    [self.view addSubview:self.optionsTableView];
    
    [self.optionsTableView registerClass:[RZDisclosureTableViewCell class] forCellReuseIdentifier:kRZDisclosureReuseIdentifier];
    [self.optionsTableView registerClass:[RZToggleTableViewCell class] forCellReuseIdentifier:kRZToggleReuseIdentifier];
    [self.optionsTableView registerClass:[RZVersionInfoTableViewCell class] forCellReuseIdentifier:kRZVersionInfoReuseIdentifier];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.debugSettingsInterface.settingsCellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if ( [[self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row] isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZDisclosureReuseIdentifier forIndexPath:indexPath];
        RZDebugMenuMultiValueItem *disclosureCellMetaData = [self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row];
        cell.textLabel.text = disclosureCellMetaData.disclosureTableViewCellTitle;
        
        NSInteger defaultValue = [disclosureCellMetaData.disclosureTableViewCellDefaultValue integerValue];
        NSString *currentSelection = [disclosureCellMetaData.selectionTitles objectAtIndex:(unsigned long)defaultValue];
        cell.detailTextLabel.text = currentSelection;
        
    }
    else if ( [[self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row] isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        RZDebugMenuToggleItem *toggleCellMetaData = [self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row];
        cell.textLabel.text = toggleCellMetaData.toggleCellTitle;
    }
    else {
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        cell.detailTextLabel.text = [self.debugSettingsInterface.settingsCellItems lastObject];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [self.optionsTableView cellForRowAtIndexPath:indexPath];
    
    if ( [cell isKindOfClass:[RZDisclosureTableViewCell class]] ) {
        
        RZDebugMenuEnvironmentsListViewController *environmentsView = [[RZDebugMenuEnvironmentsListViewController alloc] init];
        [self.navigationController pushViewController:environmentsView animated:YES];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end