//
//  RZMultiValueItemTableViewCell.m
//  RZDebugMenu
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
    [super setSelected:selected animated:animated];
    
    if ( selected ) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    CGFloat animationDuration = 0.f;
    if ( animated ) {
        animationDuration = 0.1;
    }
    
    if ( highlighted ) {
        
        [UIView animateWithDuration:animationDuration animations:^{
            self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.500 alpha:0.500];
        }];
    }
    else {
        
        [UIView animateWithDuration:animationDuration
                              delay:0.15
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             self.backgroundView.backgroundColor = [UIColor whiteColor];
                         }
                         completion:NULL
         ];
    }
}

@end
