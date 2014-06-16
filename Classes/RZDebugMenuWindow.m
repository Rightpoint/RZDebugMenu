//
//  RZDebugMenuWindow.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuWindow.h"
#import "RZDebugMenuSharedManager.h"

@implementation RZDebugMenuWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    RZDebugMenuSharedManager *sharedManager = [RZDebugMenuSharedManager sharedTopLevel];
    
    if ( [hitView isDescendantOfView:sharedManager.clearViewController.view] ) {
        return nil;
    }
    return hitView;
}

@end
