//
//  RZDebugMenuModalViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"

#import "RZSettingsInterfaceTableViewCell.h"

#import "RZDebugMenuMultiItemListViewController.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"

static NSString * const kRZNavigationBarTitle = @"Settings";
static NSString * const kRZNavigationBarDoneButtonTitle = @"Done";
static NSString * const kRZNavigationBarAddButtonTitle = @"Add";
static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

@interface RZDebugMenuModalViewController ()

@property(nonatomic, strong) UITableView *optionsTableView;

@end

@implementation RZDebugMenuModalViewController

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
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    self.optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStyleGrouped];
    
    self.optionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [self.view addSubview:self.optionsTableView];

    self.debugSettingsInterface.settingsOptionsTableView = self.optionsTableView;

    self.optionsTableView.delegate = self;
    self.optionsTableView.dataSource = self.debugSettingsInterface;

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:kRZNavigationBarDoneButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(closeView)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:kRZNavigationBarAddButtonTitle
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(addEnvironment)];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = addButton;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id currentMetaDataObject = [self.debugSettingsInterface.settingsCellItemsMetaData objectAtIndex:indexPath.row];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        RZDebugMenuMultiValueItem *disclosureCellOptions = [self.debugSettingsInterface.settingsCellItemsMetaData objectAtIndex:indexPath.row];
        NSArray *disclosureCellSelectableItems = disclosureCellOptions.selectionTitles;
        
        RZDebugMenuMultiItemListViewController *environmentsView = [[RZDebugMenuMultiItemListViewController alloc] initWithCellTitles:disclosureCellSelectableItems];
        [self.navigationController pushViewController:environmentsView animated:YES];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
