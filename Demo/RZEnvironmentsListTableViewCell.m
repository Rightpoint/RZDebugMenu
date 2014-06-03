//
//  RZEnvironmentsListTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZEnvironmentsListTableViewCell.h"

@implementation RZEnvironmentsListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.text = @"Environments";
        self.detailTextLabel.text = @"Placeholder";
    }
    return self;
}

@end
