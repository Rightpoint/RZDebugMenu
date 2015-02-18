//
//  RZDebugMenuMultiItemListViewController.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZMultiValueSelectionItem.h"

@class RZDebugMenuMultiItemListViewController;
@protocol RZDebugMenuMultiItemListViewControllerDelegate <NSObject>

- (void)multiItemListDidSelectNewItem:(RZMultiValueSelectionItem *)selectedItem;

@end

@interface RZDebugMenuMultiItemListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (id)initWithSelectionItems:(NSArray *)selectionItems delegate:(id<RZDebugMenuMultiItemListViewControllerDelegate>)delegate selectedRow:(NSInteger)selectedRow;

@end
