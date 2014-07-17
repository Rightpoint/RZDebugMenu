//
//  RZDebugMenuMultiItemListViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiItemListViewController.h"
#import "RZMultiValueSelectionItem.h"
#import "RZMultiValueItemTableViewCell.h"

static NSString * const kRZCellReuseIdentifier = @"Cell";
static NSString * const kRZNavigationBarTitle = @"Options";

@interface RZDebugMenuMultiItemListViewController ()

@property (strong, nonatomic) UITableView *selectionsTableView;
@property (strong, nonatomic) NSArray *cellItems;
@property (assign, nonatomic) NSInteger lastSelected;
@property (weak, nonatomic) id<RZDebugMenuMultiItemListViewControllerDelegate>delegate;

@end

@implementation RZDebugMenuMultiItemListViewController

- (id)initWithSelectionItems:(NSArray *)selectionItems delegate:(id<RZDebugMenuMultiItemListViewControllerDelegate>)delegate andSelectedRow:(NSInteger)selectedRow
{
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        _cellItems = [[NSArray alloc] initWithArray:selectionItems];
        _lastSelected = selectedRow;
        self.title = kRZNavigationBarTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    self.selectionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    [self.selectionsTableView registerClass:[RZMultiValueItemTableViewCell class] forCellReuseIdentifier:kRZCellReuseIdentifier];
    self.selectionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.selectionsTableView];
    
    self.selectionsTableView.delegate = self;
    self.selectionsTableView.dataSource = self;
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:self.lastSelected inSection:0];
    [self.selectionsTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:0];
}

#pragma mark - table view datasource methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMultiValueItemTableViewCell *cell = [self.selectionsTableView dequeueReusableCellWithIdentifier:kRZCellReuseIdentifier];
    if ( cell ) {
        RZMultiValueSelectionItem *currentSelectionItem = [self.cellItems objectAtIndex:indexPath.row];
        cell.textLabel.text = currentSelectionItem.selectionTitle;
    }
    
    return cell;
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMultiValueSelectionItem *currentSelectionItem = [self.cellItems objectAtIndex:indexPath.row];
    self.lastSelected = indexPath.row;
    [self.delegate multiItemListDidMakeNewSelectionAtIndexPath:currentSelectionItem];
}

@end
