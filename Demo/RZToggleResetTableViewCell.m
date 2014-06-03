//
//  RZToggleResetTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleResetTableViewCell.h"

@implementation RZToggleResetTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *applySettingsSwitch = [[UISwitch alloc] init];
        self.accessoryView = [[UIView alloc] initWithFrame:applySettingsSwitch.frame];
        [self.accessoryView addSubview:applySettingsSwitch];
        self.textLabel.text = @"Apply Changes on Reset";
    }
    return self;
}

@end
