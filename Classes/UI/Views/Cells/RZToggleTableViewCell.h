//
//  RZToggleTableViewCell.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@class RZToggleTableViewCell;

@protocol RZToggleTableViewCellDelegate <NSObject>

- (void)didChangeToggleStateOfCell:(RZToggleTableViewCell *)cell;

@end

@interface RZToggleTableViewCell : UITableViewCell

@property (weak, nonatomic) id<RZToggleTableViewCellDelegate> delegate;
@property (strong, nonatomic) UISwitch *applySettingsSwitch;

@end
