//
//  RZDebugMenuWindow.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuWindow.h"
#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuModalViewController.h"

@implementation RZDebugMenuWindow

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if ( [[hitView nextResponder] isMemberOfClass:[RZDebugMenuDummyViewController class]] ) {
        NSLog(@"dummy");
        return hitView;
    }
    NSLog(@"main");
    return nil;
}

@end
