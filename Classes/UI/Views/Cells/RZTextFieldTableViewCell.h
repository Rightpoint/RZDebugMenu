//
//  RZTextFieldTableViewCell.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZTextFieldTableViewCell;
@protocol RZTextFieldTableViewCellDelegate <NSObject>

- (void) didEditTextLabelOfCell:(RZTextFieldTableViewCell *)cell;

@end

@interface RZTextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *stringTextField;
@property (strong, nonatomic) id<RZTextFieldTableViewCellDelegate>delegate;

@end
