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
#import "RZMultiValueSelectionItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"

#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZTextFieldTableViewCell.h"
#import "RZSliderTableViewCell.h"

static NSString * const kRZNavigationBarTitle = @"Settings";
static NSString * const kRZNavigationBarDoneButtonTitle = @"Done";
static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

@interface RZDebugMenuModalViewController ()
<RZDebugMenuMultiItemListViewControllerDelegate,
RZTextFieldTableViewCellDelegate,
RZToggleTableViewCellDelegate,
RZSliderTableViewCellDelegate>

@property (strong, nonatomic) RZDebugMenuSettingsInterface *debugSettingsInterface;
@property (strong, nonatomic) UITableView *optionsTableView;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppearOrHide:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidAppearOrHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSIndexPath *selectedIndexPath = [self.optionsTableView indexPathForSelectedRow];
    if ( selectedIndexPath ) {
        [self.optionsTableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    }
}

- (void)keyboardDidAppearOrHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    UIEdgeInsets newTableViewEdgeInsets = self.optionsTableView.contentInset;
    UIEdgeInsets newEdgeInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    
    newTableViewEdgeInsets.bottom = newEdgeInset.bottom - newTableViewEdgeInsets.bottom;
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | animationCurve
                     animations:^{
                         self.optionsTableView.contentInset = newTableViewEdgeInsets;
                     }
                     completion:nil];
    
}

#pragma mark - nav bar buttons methods

- (void)closeView
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [cell isKindOfClass:[RZToggleTableViewCell class]] ) {
        RZToggleTableViewCell *toggleCell = (RZToggleTableViewCell *)cell;
        toggleCell.delegate = self;
        cell = toggleCell;
    }
    else if ( [cell isKindOfClass:[RZTextFieldTableViewCell class]] ) {
        RZTextFieldTableViewCell *textFieldCell = (RZTextFieldTableViewCell *)cell;
        textFieldCell.delegate = self;
        cell = textFieldCell;
    }
    else if ( [cell isKindOfClass:[RZSliderTableViewCell class]] ) {
        RZSliderTableViewCell *sliderCell = (RZSliderTableViewCell *)cell;
        sliderCell.delegate = self;
        cell = sliderCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZDebugMenuSettingsItem *currentMetaDataObject = [self.debugSettingsInterface settingsItemAtIndexPath:indexPath];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        RZDebugMenuMultiValueItem *disclosureCellOptions = (RZDebugMenuMultiValueItem *)currentMetaDataObject;
        NSArray *disclosureCellSelectableItems = disclosureCellOptions.selectionItems;
        
        RZDebugMenuMultiItemListViewController *environmentsViewController = [[RZDebugMenuMultiItemListViewController alloc] initWithSelectionItems:disclosureCellSelectableItems andDelegate:self];
        [self.navigationController pushViewController:environmentsViewController animated:YES];
    }
}

- (void)multiItemListDidMakeNewSelectionAtIndexPath:(RZMultiValueSelectionItem *)selectedItem
{
    NSIndexPath *selectedIndexPath = [self.optionsTableView indexPathForSelectedRow];
    RZDebugMenuMultiValueItem *disclosureMultiValueItem = (RZDebugMenuMultiValueItem *)[self.debugSettingsInterface settingsItemAtIndexPath:selectedIndexPath];
    [self.debugSettingsInterface setValue:selectedItem.selectionValue forDebugSettingsKey:disclosureMultiValueItem.settingsKey];
    RZDisclosureTableViewCell *selectedCell = (RZDisclosureTableViewCell *)[self.optionsTableView cellForRowAtIndexPath:selectedIndexPath];
    selectedCell.detailTextLabel.text = selectedItem.selectionTitle;
}

- (void)didChangeToggleStateOfCell:(RZToggleTableViewCell *)cell
{
    NSIndexPath *toggleCellIndexPath = [self.optionsTableView indexPathForCell:cell];
    RZDebugMenuToggleItem *toggleItem = (RZDebugMenuToggleItem *)[self.debugSettingsInterface settingsItemAtIndexPath:toggleCellIndexPath];
    [self.debugSettingsInterface setValue:[NSNumber numberWithBool:cell.applySettingsSwitch.on] forDebugSettingsKey:toggleItem.settingsKey];
}

- (void)didEditTextLabelOfCell:(RZTextFieldTableViewCell *)cell
{
    NSIndexPath *textFieldIndexPath = [self.optionsTableView indexPathForCell:cell];
    RZDebugMenuTextFieldItem *textFieldItem = (RZDebugMenuTextFieldItem *)[self.debugSettingsInterface settingsItemAtIndexPath:textFieldIndexPath];
    [self.debugSettingsInterface setValue:cell.stringTextField.text forDebugSettingsKey:textFieldItem.settingsKey];
}

- (void)didChangeSliderPosition:(RZSliderTableViewCell *)cell
{
    NSIndexPath *sliderIndexPath = [self.optionsTableView indexPathForCell:cell];
    RZDebugMenuSliderItem *sliderItem = (RZDebugMenuSliderItem *)[self.debugSettingsInterface settingsItemAtIndexPath:sliderIndexPath];
    [self.debugSettingsInterface setValue:[NSNumber numberWithFloat:cell.cellSlider.value] forDebugSettingsKey:sliderItem.settingsKey];
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end
