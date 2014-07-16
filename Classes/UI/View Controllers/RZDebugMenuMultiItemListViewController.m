//
//  RZDebugMenuMultiItemListViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiItemListViewController.h"
#import "RZMultiValueSelectionItem.h"

static NSString * const kRZCellReuseIdentifier = @"Cell";
static NSString * const kRZNavigationBarTitle = @"Options";

@interface RZDebugMenuMultiItemListViewController ()

@property (strong, nonatomic) UITableView *selectionsTableView;
@property (strong, nonatomic) NSArray *cellItems;
@property (strong, nonatomic) NSIndexPath *lastSelection;
@property (weak, nonatomic) id<RZDebugMenuMultiItemListViewControllerDelegate>delegate;

@end

@implementation RZDebugMenuMultiItemListViewController

- (id)initWithSelectionItems:(NSArray *)selectionItems andDelegate:(id<RZDebugMenuMultiItemListViewControllerDelegate>)delegate
{
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        _cellItems = [[NSArray alloc] initWithArray:selectionItems];
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
    [self.selectionsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kRZCellReuseIdentifier];
    self.selectionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.selectionsTableView];
    
    self.selectionsTableView.delegate = self;
    self.selectionsTableView.dataSource = self;
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
    UITableViewCell *cell = [self.selectionsTableView dequeueReusableCellWithIdentifier:kRZCellReuseIdentifier];
    if ( cell ) {
        RZMultiValueSelectionItem *currentSelectionItem = [self.cellItems objectAtIndex:indexPath.row];
        cell.textLabel.text = currentSelectionItem.selectionTitle;
    }
    
    if ( [indexPath compare:self.lastSelection] == NSOrderedSame ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMultiValueSelectionItem *currentSelectionItem = [self.cellItems objectAtIndex:indexPath.row];
    UITableViewCell *selectedCell = [self.selectionsTableView cellForRowAtIndexPath:indexPath];
    selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.lastSelection = indexPath;
    [self.delegate multiItemListDidMakeNewSelectionAtIndexPath:currentSelectionItem];
}

@end
