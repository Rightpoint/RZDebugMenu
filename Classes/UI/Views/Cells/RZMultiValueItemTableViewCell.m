//
//  RZMultiValueItemTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/16/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZMultiValueItemTableViewCell.h"

@implementation RZMultiValueItemTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        selectedView.backgroundColor = [UIColor whiteColor];
        self.backgroundView = selectedView;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if ( highlighted ) {
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.500];
    }
}

@end
