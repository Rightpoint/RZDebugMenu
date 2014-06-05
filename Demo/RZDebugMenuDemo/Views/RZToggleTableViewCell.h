//
//  RZToggleResetTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZSettingsInterfaceTableViewCell.h"

@interface RZToggleTableViewCell : UITableViewCell

@property(nonatomic, strong) UISwitch *applySettingsSwitch;
@property(nonatomic, strong) NSString *cellTitle;

//- (id)initWithStyle:(UITableViewCellStyle)style cellTitle:(NSString *)title andSwitchValue:(BOOL)value;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
