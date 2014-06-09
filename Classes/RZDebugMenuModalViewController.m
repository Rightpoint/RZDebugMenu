//
//  RZDebugMenuModalViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuRootViewController.h"
#import "RZDebugMenuMultiItemListViewController.h"
#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"
#import "RZSettingsInterfaceTableViewCell.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"

static NSString * const kRZNavigationBarTitle = @"Env Settings";
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
        
    }
    return self;
}

- (id)initWithInterface:(RZDebugMenuSettingsInterface *)interface
{
    self = [super init];
    if ( self ) {
        self.title = kRZNavigationBarTitle;
        _debugSettingsInterface = interface;
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
    UITableViewCell *cell = nil;
    id currentMetaDataObject = [self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZDisclosureReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = ((RZDebugMenuMultiValueItem *)currentMetaDataObject).disclosureTableViewCellTitle;
        
        NSInteger defaultValue = [((RZDebugMenuMultiValueItem *)currentMetaDataObject).disclosureTableViewCellDefaultValue integerValue];
        NSString *currentSelection = [((RZDebugMenuMultiValueItem *)currentMetaDataObject).selectionTitles objectAtIndex:(unsigned long)defaultValue];
        cell.detailTextLabel.text = currentSelection;
        
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = ((RZDebugMenuToggleItem *)currentMetaDataObject).toggleCellTitle;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuVersionItem class]] ){
        
        cell = [self.optionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        RZDebugMenuVersionItem *versionItem = [self.debugSettingsInterface.settingsCellItems lastObject];
        cell.detailTextLabel.text = versionItem.versionNumber;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id currentMetaDataObject = [self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        RZDebugMenuMultiValueItem *disclosureCellOptions = [self.debugSettingsInterface.settingsCellItems objectAtIndex:indexPath.row];
        NSArray *disclosureCellSelectableItems = disclosureCellOptions.selectionTitles;
        
        RZDebugMenuMultiItemListViewController *environmentsView = [[RZDebugMenuMultiItemListViewController alloc] initWithCellTitles:disclosureCellSelectableItems];
        [self.navigationController pushViewController:environmentsView animated:YES];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
