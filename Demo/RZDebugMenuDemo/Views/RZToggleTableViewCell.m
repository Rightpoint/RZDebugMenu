//
//  RZToggleResetTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleTableViewCell.h"
#import "RZSettingsManager.h"

@implementation RZToggleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        BOOL switchValue = [RZSettingsManager getToggleValue];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *applySettingsSwitch = [[UISwitch alloc] init];
        applySettingsSwitch.on = switchValue;
        self.accessoryView = [[UIView alloc] initWithFrame:applySettingsSwitch.frame];
        [self.accessoryView addSubview:applySettingsSwitch];
        self.textLabel.text = @"Apply Changes on Reset";
    }
    return self;
}

@end
