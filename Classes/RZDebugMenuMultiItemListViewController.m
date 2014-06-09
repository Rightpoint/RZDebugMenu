//
//  RZDebugMenuEnvironmentsListViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiItemListViewController.h"

@interface RZDebugMenuMultiItemListViewController ()

@property(nonatomic, strong) UITableView *selectionsTableView;

@end

static NSString * const kRZNavigationBarTitle = @"Environments";

@implementation RZDebugMenuMultiItemListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCellTitles:(NSArray *)titles
{
    self = [super init];
    if ( self ) {
        _cellTitles = [[NSArray alloc] initWithArray:titles];
        self.title = kRZNavigationBarTitle;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    self.selectionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
    self.selectionsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.selectionsTableView];
    
    self.selectionsTableView.delegate = self;
    self.selectionsTableView.dataSource = self;
}

#pragma mark - table view delegate methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [self.cellTitles objectAtIndex:indexPath.row];
    return cell;
}

@end
