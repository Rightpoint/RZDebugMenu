//
//  RZToggleResetTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleTableViewCell.h"

@implementation RZToggleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style cellTitle:(NSString *)title andSwitchValue:(BOOL)value
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.applySettingsSwitch = [[UISwitch alloc] init];
        self.applySettingsSwitch.on = value;
        self.accessoryView = [[UIView alloc] initWithFrame:self.applySettingsSwitch.frame];
        [self.accessoryView addSubview:self.applySettingsSwitch];
        self.textLabel.text = title;
    }
    return self;
}

@end
