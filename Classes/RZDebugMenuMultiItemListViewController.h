//
//  RZDebugMenuEnvironmentsListViewController.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuMultiItemListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *cellTitles;

- (id)initWithCellTitles:(NSArray *)titles;

@end
