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

@end

@implementation RZDebugMenuMultiItemListViewController

- (id)initWithSelectionItems:(NSArray *)selectionItems
{
    self = [super init];
    if ( self ) {
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
    return cell;
}

#pragma mark - table view delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMultiValueSelectionItem* selectedItem = [self.cellItems objectAtIndex:indexPath.row];
    [selectedItem.delegate didMakeNewSelection:selectedItem withIndexPath:indexPath];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
