//
//  RZSliderTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSliderTableViewCell.h"

@implementation RZSliderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
