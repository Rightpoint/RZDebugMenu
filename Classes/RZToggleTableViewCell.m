//
//  RZToggleResetTableViewCell.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleTableViewCell.h"

@implementation RZToggleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.applySettingsSwitch = [[UISwitch alloc] init];
        self.accessoryView = [[UIView alloc] initWithFrame:self.applySettingsSwitch.frame];
        [self.accessoryView addSubview:self.applySettingsSwitch];
    }
    return self;
}

@end
