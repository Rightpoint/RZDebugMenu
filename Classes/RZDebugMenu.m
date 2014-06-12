//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"
#import "RZDebugMenuModalViewController.h"

@interface RZDebugMenu ()

@property(nonatomic, strong) UIWindow *secondWindow;

@end

@implementation RZDebugMenu

-(id)init
{
    @throw [NSException exceptionWithName:@"Illegal allocation of setup interface"
                                   reason:@"You can't instantiate RZDebugMenu. Only method is - (void)enable"
                                 userInfo:nil];
}

+ (UIWindow *)enable
{
    UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
    RZDebugMenuModalViewController *modalViewController = [[RZDebugMenuModalViewController alloc] init];
    
    // Set up gesture and attach to application window
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] init];
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [mainWindow addGestureRecognizer:tripleTap];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    CGFloat width = CGRectGetWidth(mainScreen.bounds);
    CGFloat height = CGRectGetHeight(mainScreen.bounds);
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    window.rootViewController = modalViewController;
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    
    return window;
}



@end
