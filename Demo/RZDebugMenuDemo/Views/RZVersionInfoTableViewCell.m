//
//  RZVersionInfoTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZVersionInfoTableViewCell.h"

@implementation RZVersionInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style andVersionNumber:(NSString *)version
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.text = @"Version";
        self.detailTextLabel.text = version;
    }
    return self;
}

@end
