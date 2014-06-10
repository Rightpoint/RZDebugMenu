//
//  RZVersionInfoTableViewCell.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZVersionInfoTableViewCell.h"

@implementation RZVersionInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end
