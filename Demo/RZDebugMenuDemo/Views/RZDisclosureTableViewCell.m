//
//  RZEnvironmentsListTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDisclosureTableViewCell.h"

@implementation RZDisclosureTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.text = @"Environments";
        self.detailTextLabel.text = @"Placeholder";
    }
    return self;
}

@end
