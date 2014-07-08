//
//  RZDebugMenuWindow.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuWindow.h"

@implementation RZDebugMenuWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if ( hitView == self.rootViewController.view ) {
        return nil;
    }
    return hitView;
}

@end
