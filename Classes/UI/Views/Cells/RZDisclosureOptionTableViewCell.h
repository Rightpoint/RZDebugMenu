//
//  RZDisclosureOptionTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/23/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZDisclosureOptionTableViewCell;
@protocol RZDisclosureOptionTableViewCellDelegate <NSObject>

- (void)didMakeNewSelection:(RZDisclosureOptionTableViewCell *)cell;

@end

@interface RZDisclosureOptionTableViewCell : UITableViewCell

- (id)initWithDelegate:(id<RZDisclosureOptionTableViewCellDelegate>)delegate reuseIdentifier:(NSString *)identifier;

@end
