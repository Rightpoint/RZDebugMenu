//
//  RZToggleTableViewCell.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZToggleTableViewCell.h"

#import "RZDebugMenuSettingsInterface.h"

@implementation RZToggleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.applySettingsSwitch = [[UISwitch alloc] init];
        [self.applySettingsSwitch addTarget:self action:@selector(changeState) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = [[UIView alloc] initWithFrame:self.applySettingsSwitch.frame];
        [self.accessoryView addSubview:self.applySettingsSwitch];
    }
    return self;
}

- (void)changeState
{
    [self.delegate didChangeToggleStateOfCell:self];
}

@end
