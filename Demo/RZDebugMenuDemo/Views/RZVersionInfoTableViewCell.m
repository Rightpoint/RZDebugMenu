//
//  RZVersionInfoTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZVersionInfoTableViewCell.h"

@implementation RZVersionInfoTableViewCell

//- (id)initWithStyle:(UITableViewCellStyle)style andVersionNumber:(NSString *)version
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.text = @"Version";
        self.detailTextLabel.text = self.versionNumber;
    }
    return self;
}

@end
