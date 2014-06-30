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
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        _cellSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, width, height)];
        [self addSubview:_cellSlider];
    }
    return self;
}

@end
