//
//  RZClearViewController.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

#import "RZDebugMenu.h"

static NSString * const kRZDebugMenuButtonTitle = @"\u2699";

@interface RZDebugMenuClearViewController ()

@property (weak, nonatomic) id<RZDebugMenuClearViewControllerDelegate> delegate;
@property (strong, nonatomic) UIButton *displayDebugMenuButton;
@property (strong, nonatomic) UIPanGestureRecognizer *dragGesture;

@end

@implementation RZDebugMenuClearViewController

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if ( self ) {
        _delegate = delegate;
        
        _dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragButton:)];
        
        _displayDebugMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 225, 35, 35)];
        _displayDebugMenuButton.alpha = 0.80;
        _displayDebugMenuButton.backgroundColor = [UIColor whiteColor];
        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateNormal];
        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateHighlighted];
        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateSelected];
        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_displayDebugMenuButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
        _displayDebugMenuButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [_displayDebugMenuButton addTarget:self action:@selector(displayDebugMenu) forControlEvents:UIControlEventTouchUpInside];
        _displayDebugMenuButton.clipsToBounds = YES;
        _displayDebugMenuButton.layer.cornerRadius = 8;
        _displayDebugMenuButton.layer.borderWidth = 1.5f;
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

- (void)displayDebugMenu
{
    [self.delegate clearViewControllerDebugMenuButtonPressed:self];
}

- (void)dragButton:(UIPanGestureRecognizer *)panGesture
{
    CGFloat const topBoundaryInset = 20.0f;
    CGFloat const bounceOffset = 15.f;
    CGFloat const buttonWidth = self.displayDebugMenuButton.bounds.size.width;
    CGPoint translation = [panGesture translationInView:self.view];
    CGPoint velocity = [panGesture velocityInView:self.view];
    UIView *draggedButton = panGesture.view;
    CGRect newButtonFrame = draggedButton.frame;
    
    if ( panGesture.state == UIGestureRecognizerStateChanged ) {
        newButtonFrame.origin.x += translation.x;
        newButtonFrame.origin.y += translation.y;
        
        if ( newButtonFrame.origin.x >= CGRectGetWidth(self.view.bounds) - buttonWidth ) {
            newButtonFrame.origin.x = CGRectGetWidth(self.view.bounds) - buttonWidth;
        }
        if ( newButtonFrame.origin.x <= 0 ) {
            newButtonFrame.origin.x = 0;
        }
        if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth) {
            newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth;
        }
        if ( newButtonFrame.origin.y <= topBoundaryInset) {
            newButtonFrame.origin.y = topBoundaryInset;
        }
        
        draggedButton.frame = newButtonFrame;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded )
    {
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             CGRect newButtonFrame = draggedButton.frame;
                             newButtonFrame.origin.x += velocity.x;
                             newButtonFrame.origin.y += velocity.y;
                             
                             if ( newButtonFrame.origin.x >= CGRectGetWidth(self.view.bounds) - buttonWidth ) {
                                 newButtonFrame.origin.x = CGRectGetWidth(self.view.bounds) - buttonWidth + bounceOffset;
                             }
                             if ( newButtonFrame.origin.x <= 0 ) {
                                 newButtonFrame.origin.x = -bounceOffset;
                             }
                             if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth) {
                                 newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth + bounceOffset;
                             }
                             if ( newButtonFrame.origin.y <= topBoundaryInset) {
                                 newButtonFrame.origin.y = topBoundaryInset - bounceOffset;
                             }
                             
                             draggedButton.frame = newButtonFrame;
                         }
                         completion:^(BOOL completed) {
                             
                             // Bounce back animation
                             CGRect newButtonFrame = draggedButton.frame;
                             if ( newButtonFrame.origin.x >= CGRectGetWidth(self.view.bounds) - buttonWidth ) {
                                 newButtonFrame.origin.x = CGRectGetWidth(self.view.bounds) - buttonWidth;
                             }
                             if ( newButtonFrame.origin.x <= 0 ) {
                                 newButtonFrame.origin.x = 0;
                             }
                             if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth) {
                                 newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth;
                             }
                             if ( newButtonFrame.origin.y <= topBoundaryInset) {
                                 newButtonFrame.origin.y = topBoundaryInset;
                             }
                             
                             [UIView animateWithDuration:0.25 animations:^{
                                 draggedButton.frame = newButtonFrame;
                                 [panGesture setTranslation:CGPointZero inView:self.view];
                             }];
                         }];
    }
}

@end
