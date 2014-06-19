//
//  RZClearViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

#import "RZDebugMenu.h"

@interface RZDebugMenuClearViewController ()

@property (strong, nonatomic) UIButton *displayDebugMenuButton;
@property (strong, nonatomic) UIPanGestureRecognizer *dragGesture;

@end

@implementation RZDebugMenuClearViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if ( self ) {

        _delegate = delegate;
        
        _displayDebugMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 37, 37)];
        [_displayDebugMenuButton setImage:[UIImage imageNamed:@"greg.jpeg"] forState:UIControlStateNormal];
        [_displayDebugMenuButton addTarget:self.delegate action:@selector(clearViewController:didShowDebugMenu:) forControlEvents:UIControlEventTouchUpInside];
        _displayDebugMenuButton.clipsToBounds = YES;
        _displayDebugMenuButton.layer.cornerRadius = 12;
        _displayDebugMenuButton.layer.borderWidth = 1.5f;
        
        _dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragButton:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.displayDebugMenuButton addGestureRecognizer:self.dragGesture];
    [self.view addSubview:self.displayDebugMenuButton];
}

- (void)dragButton:(UIPanGestureRecognizer *)panGesture
{
    CGPoint translation = [panGesture translationInView:self.view];
    CGPoint velocity = [panGesture velocityInView:self.view];
    UIView *draggedButton = panGesture.view;
    CGRect newButtonFrame = draggedButton.frame;
    CGFloat navigationControllerHeight = self.navigationController.navigationBar.frame.size.height;
    
    if ( panGesture.state == UIGestureRecognizerStateChanged ) {
        velocity = [panGesture velocityInView:self.view];
        newButtonFrame.origin.x += translation.x;
        newButtonFrame.origin.y += translation.y;
        draggedButton.frame = newButtonFrame;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded )
    {
        [UIView animateWithDuration:0.27
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             CGRect newButtonFrame = draggedButton.frame;
                             newButtonFrame.origin.x += velocity.x;
                             newButtonFrame.origin.y += velocity.y;
                             
                             if ( newButtonFrame.origin.x >= CGRectGetMaxX(self.view.frame) ) {
                                 newButtonFrame.origin.x = CGRectGetMaxX(self.view.frame) - 30;
                             }
                             if ( newButtonFrame.origin.y >= CGRectGetMaxY(self.view.frame) ) {
                                 newButtonFrame.origin.y = CGRectGetMaxY(self.view.frame) - 30;
                             }
                             if ( newButtonFrame.origin.x <= CGRectGetMinX(self.view.frame) ) {
                                 newButtonFrame.origin.x = CGRectGetMinX(self.view.frame) - 5;
                             }
                             if ( newButtonFrame.origin.y <= navigationControllerHeight) {
                                 newButtonFrame.origin.y = navigationControllerHeight + 23;
                             }
                             
                             draggedButton.frame = newButtonFrame;
                         }
                         completion:^(BOOL completed) {
                             
                             CGRect newButtonFrame = draggedButton.frame;
                             if ( newButtonFrame.origin.x + 37 > CGRectGetMaxX(self.view.frame) ) {
                                 newButtonFrame.origin.x = CGRectGetMaxX(self.view.frame) - 40;
                             }
                             
                             if ( newButtonFrame.origin.y + 37 > CGRectGetMaxY(self.view.frame) ) {
                                 newButtonFrame.origin.y = CGRectGetMaxY(self.view.frame) - 40;
                             }
                             if ( newButtonFrame.origin.x < CGRectGetMinX(self.view.frame) ) {
                                 newButtonFrame.origin.x = CGRectGetMinX(self.view.frame) + 3;
                             }
                             if ( newButtonFrame.origin.y < CGRectGetMinY(self.view.frame) + self.navigationController.navigationBar.frame.size.height ) {
                                 newButtonFrame.origin.y = CGRectGetMinY(self.view.frame) + self.navigationController.navigationBar.frame.size.height;
                             }
                             
                             [UIView animateWithDuration:0.1 animations:^{
                                 draggedButton.frame = newButtonFrame;
                                 [panGesture setTranslation:CGPointZero inView:self.view];
                             }];
                         }];
    }
}

@end
