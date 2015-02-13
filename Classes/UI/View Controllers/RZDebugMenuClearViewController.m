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

// Button Theme
static const CGRect kRZButtonFrame = { .origin = { .x = 70.0f, .y = 225.0f }, .size = { .width = 35.0f, .height = 35.0f } };
static const CGFloat kRZButtonGlyphFontSize = 30.0f;
static const CGFloat kRZBorderWidth = 1.5f;

// Button Animations
static const CGFloat kRZBoundaryInset = 20.0f;
static const CGFloat kRZBounceOffset = 15.0f;

static const NSTimeInterval kRZButtonMoveAnimatinoDuration = 0.3f;
static const NSTimeInterval kRZButtonBounceBackAnimatinoDuration = 0.25f;

@interface RZDebugMenuClearViewController ()

@property (weak, nonatomic) id <RZDebugMenuClearViewControllerDelegate> delegate;
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
        
        _displayDebugMenuButton = [[UIButton alloc] initWithFrame:kRZButtonFrame];
        _displayDebugMenuButton.alpha = 0.80;
        _displayDebugMenuButton.backgroundColor = [UIColor whiteColor];

        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateNormal];
        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateHighlighted];
        [_displayDebugMenuButton setTitle:kRZDebugMenuButtonTitle forState:UIControlStateSelected];

        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_displayDebugMenuButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

        [_displayDebugMenuButton.titleLabel setFont:[UIFont systemFontOfSize:kRZButtonGlyphFontSize]];

        _displayDebugMenuButton.titleLabel.textAlignment = NSTextAlignmentLeft;

        [_displayDebugMenuButton addTarget:self action:@selector(displayDebugMenu) forControlEvents:UIControlEventTouchUpInside];

        _displayDebugMenuButton.clipsToBounds = YES;
        _displayDebugMenuButton.layer.cornerRadius = 8;
        _displayDebugMenuButton.layer.borderWidth = kRZBorderWidth;
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
    CGFloat const topBoundaryInset = kRZBoundaryInset;
    CGFloat const bounceOffset = kRZBounceOffset;
    CGFloat const buttonWidth = CGRectGetWidth(self.displayDebugMenuButton.bounds);

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
        if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth ) {
            newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth;
        }
        if ( newButtonFrame.origin.y <= topBoundaryInset ) {
            newButtonFrame.origin.y = topBoundaryInset;
        }
        
        draggedButton.frame = newButtonFrame;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded )
    {
        [UIView animateWithDuration:kRZButtonMoveAnimatinoDuration
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
                             if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth ) {
                                 newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth + bounceOffset;
                             }
                             if ( newButtonFrame.origin.y <= topBoundaryInset ) {
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
                             if ( newButtonFrame.origin.y >= CGRectGetHeight(self.view.bounds) - buttonWidth ) {
                                 newButtonFrame.origin.y = CGRectGetHeight(self.view.bounds) - buttonWidth;
                             }
                             if ( newButtonFrame.origin.y <= topBoundaryInset ) {
                                 newButtonFrame.origin.y = topBoundaryInset;
                             }

                             [UIView animateWithDuration:kRZButtonBounceBackAnimatinoDuration animations:^{
                                 draggedButton.frame = newButtonFrame;
                                 [panGesture setTranslation:CGPointZero inView:self.view];
                             }];
                         }];
    }
}

@end
