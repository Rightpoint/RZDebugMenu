//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

@implementation RZDebugMenu

+ (UIWindow *)enable
{
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    CGFloat width = CGRectGetWidth(mainScreen.bounds);
    CGFloat height = CGRectGetHeight(mainScreen.bounds);
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    return window;
}

@end
