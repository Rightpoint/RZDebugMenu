//
//  RZClearViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/19/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

#import "RZDebugMenu.h"

static NSString * const kRZDebugMenuButtonImageName = @"greg.jpeg";

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
        
        _displayDebugMenuButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 37, 37)];
        _displayDebugMenuButton.alpha = 0.80;
        _displayDebugMenuButton.backgroundColor = [UIColor blackColor];
        [_displayDebugMenuButton setImage:[UIImage imageNamed:kRZDebugMenuButtonImageName] forState:UIControlStateNormal];
        [_displayDebugMenuButton addTarget:self action:@selector(displayDebugMenu) forControlEvents:UIControlEventTouchUpInside];
        _displayDebugMenuButton.clipsToBounds = YES;
        _displayDebugMenuButton.layer.cornerRadius = 12;
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
    CGFloat const buttonWidth = self.displayDebugMenuButton.bounds.size.width;
    CGPoint translation = [panGesture translationInView:self.view];
    UIView *draggedButton = panGesture.view;
    CGRect newButtonFrame = draggedButton.frame;
    
    if ( panGesture.state == UIGestureRecognizerStateChanged || panGesture.state == UIGestureRecognizerStateEnded ) {
        newButtonFrame.origin.x += translation.x;
        newButtonFrame.origin.y += translation.y;
        
        if ( newButtonFrame.origin.x >= CGRectGetMaxX(self.view.frame) - buttonWidth ) {
            newButtonFrame.origin.x = CGRectGetMaxX(self.view.frame) - buttonWidth;
        }
        if ( newButtonFrame.origin.x <= 0 ) {
            newButtonFrame.origin.x = 0;
        }
        if ( newButtonFrame.origin.y >= CGRectGetMaxY(self.view.frame) - buttonWidth) {
            newButtonFrame.origin.y = CGRectGetMaxY(self.view.frame) - buttonWidth;
        }
        if ( newButtonFrame.origin.y <= CGRectGetMinY(self.view.frame) + topBoundaryInset) {
            newButtonFrame.origin.y = CGRectGetMinY(self.view.frame) + topBoundaryInset;
        }
        
        draggedButton.frame = newButtonFrame;
        [panGesture setTranslation:CGPointZero inView:self.view];
        
    }
}

@end
