//
//  RZDebugMenuModalViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"

#import "RZDebugMenuSettingsItem.h"
#import "RZDebugMenuMultiItemListViewController.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"

static NSString * const kRZNavigationBarTitle = @"Settings";
static NSString * const kRZNavigationBarDoneButtonTitle = @"Done";
static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

@interface RZDebugMenuModalViewController ()

@property(nonatomic, strong) RZDebugMenuSettingsInterface *debugSettingsInterface;
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
    
    self.navigationItem.rightBarButtonItem = doneButton;
}

#pragma mark - nav bar buttons methods

- (void)closeView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view delegate methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZDebugMenuSettingsItem *currentMetaDataObject = [self.debugSettingsInterface settingsItemAtIndexPath:indexPath];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        RZDebugMenuMultiValueItem *disclosureCellOptions = (RZDebugMenuMultiValueItem *)currentMetaDataObject;
        NSArray *disclosureCellSelectableItems = disclosureCellOptions.selectionItems;
        
        RZDebugMenuMultiItemListViewController *environmentsViewController = [[RZDebugMenuMultiItemListViewController alloc] initWithSelectionItems:disclosureCellSelectableItems];
        [self.navigationController pushViewController:environmentsViewController animated:YES];
        [self.optionsTableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end
