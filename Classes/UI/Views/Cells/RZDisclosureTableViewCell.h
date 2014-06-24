//
//  RZDisclosureTableViewCell.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZDisclosureTableViewCell;
@protocol RZDisclosureTableViewCellDelegate <NSObject>

- (void)didSelectDisclosureCell:(RZDisclosureTableViewCell *)cell;

@end

@interface RZDisclosureTableViewCell : UITableViewCell

@property (weak, nonatomic) id<RZDisclosureTableViewCellDelegate>delegate;

@end
