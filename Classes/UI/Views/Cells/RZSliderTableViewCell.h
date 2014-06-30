//
//  RZSliderTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZSliderTableViewCell;
@protocol RZSliderTableViewCellDelegate <NSObject>

- (void)didChangeSliderPosition:(RZSliderTableViewCell *)cell;

@end

@interface RZSliderTableViewCell : UITableViewCell

@property (strong, nonatomic) UISlider *cellSlider;
@property (weak, nonatomic) id<RZSliderTableViewCellDelegate>delegate;

@end
