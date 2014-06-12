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

+ (void)enable
{
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *applicationWindow = application.delegate.window;
    
    RZDebugMenuModalViewController *modalViewController = [[RZDebugMenuModalViewController alloc] init];
    
    // Set up gesture and attach to application window
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] init];
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [applicationWindow addGestureRecognizer:tripleTap];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:mainScreen.bounds];
    window.rootViewController = modalViewController;
    window.backgroundColor = [UIColor redColor];
    window.windowLevel = UIWindowLevelAlert;
    window.hidden = NO;
    
    [applicationWindow addSubview:window];
}



@end
