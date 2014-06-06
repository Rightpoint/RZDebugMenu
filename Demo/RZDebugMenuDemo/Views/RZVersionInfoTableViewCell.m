//
//  RZVersionInfoTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZVersionInfoTableViewCell.h"

static NSString * const kRZVersionTitle = @"Verison";
static NSString * const kRZVersionNumber = @"0.0.1";

@implementation RZVersionInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.text = kRZVersionTitle;
        self.detailTextLabel.text = kRZVersionNumber;
    }
    return self;
}

@end
