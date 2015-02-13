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
static const CGFloat kRZMargin = 50.0f;

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

        [self createDebugButton];
    }

    return self;
}

- (void)createDebugButton
{
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.displayDebugMenuButton addGestureRecognizer:self.dragGesture];
    [self.view addSubview:self.displayDebugMenuButton];
}

- (void)scaleButtonDown
{
    CGRect const buttonShrinkFrame = CGRectInset(self.displayDebugMenuButton.frame, 1, 1);
    [self.displayDebugMenuButton.titleLabel setFont:[UIFont systemFontOfSize:29.5]];
    self.displayDebugMenuButton.frame = buttonShrinkFrame;
}

- (void)displayDebugMenu
{
    [self scaleButtonUp];
    [self.delegate clearViewControllerDebugMenuButtonPressed:self];
}

- (void)scaleButtonUp
{
    CGRect const enlargeFrame = CGRectMake(0, 0, 35, 35);
    CGPoint oldCenter = self.displayDebugMenuButton.center;
    [self.displayDebugMenuButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    self.displayDebugMenuButton.frame = enlargeFrame;
    self.displayDebugMenuButton.center = oldCenter;
}

- (void)dragButton:(UIPanGestureRecognizer *)panGesture
{
    [self scaleButtonUp];
    
    CGFloat const topBoundaryInset = kRZBoundaryInset;
    CGFloat const edgeStickMargin = kRZMargin;
    CGFloat const buttonWidth = CGRectGetWidth(self.displayDebugMenuButton.bounds);
    
    CGFloat const viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat const viewHeight = CGRectGetHeight(self.view.bounds);

    CGPoint translation = [panGesture translationInView:self.view];
    UIView *draggedButton = panGesture.view;
    CGRect newButtonFrame = draggedButton.frame;
    
    if ( panGesture.state == UIGestureRecognizerStateChanged ) {
        newButtonFrame.origin.x += translation.x;
        newButtonFrame.origin.y += translation.y;
        
        if ( newButtonFrame.origin.x >= viewWidth - buttonWidth ) {
            newButtonFrame.origin.x = viewWidth - buttonWidth;
        }
        if ( newButtonFrame.origin.x <= 0 ) {
            newButtonFrame.origin.x = 0;
        }
        if ( newButtonFrame.origin.y >= viewHeight - buttonWidth ) {
            newButtonFrame.origin.y = viewHeight - buttonWidth;
        }
        if ( newButtonFrame.origin.y <= topBoundaryInset ) {
            newButtonFrame.origin.y = topBoundaryInset;
        }
        
        draggedButton.frame = newButtonFrame;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
    }
    else if ( panGesture.state == UIGestureRecognizerStateEnded ) {
        
        CGRect newButtonFrame = draggedButton.frame;
        if ( newButtonFrame.origin.x >= viewWidth - buttonWidth - edgeStickMargin ) {
            newButtonFrame.origin.x = viewWidth - buttonWidth;
        }
        if ( newButtonFrame.origin.x <= edgeStickMargin ) {
            newButtonFrame.origin.x = 0;
        }
        if ( newButtonFrame.origin.y >= viewHeight - buttonWidth - edgeStickMargin ) {
            newButtonFrame.origin.y = viewHeight - buttonWidth;
        }
        if ( newButtonFrame.origin.y <= topBoundaryInset + edgeStickMargin ) {
            newButtonFrame.origin.y = topBoundaryInset;
        }

        [UIView animateWithDuration:0.25 animations:^{
            draggedButton.frame = newButtonFrame;
            [panGesture setTranslation:CGPointZero inView:self.view];
        }];
    }
}

@end
