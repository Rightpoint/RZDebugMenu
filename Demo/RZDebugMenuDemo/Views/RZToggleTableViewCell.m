//
//  RZToggleResetTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleTableViewCell.h"

@implementation RZToggleTableViewCell

//- (id)initWithStyle:(UITableViewCellStyle)style cellTitle:(NSString *)title andSwitchValue:(BOOL)value
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.applySettingsSwitch = [[UISwitch alloc] init];
//        self.applySettingsSwitch.on = YES;
        self.accessoryView = [[UIView alloc] initWithFrame:self.applySettingsSwitch.frame];
        [self.accessoryView addSubview:self.applySettingsSwitch];
        self.textLabel.text = self.cellTitle;
    }
    return self;
}

@end
