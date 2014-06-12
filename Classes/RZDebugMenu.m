//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"
#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuSettingsInterface.h"

static NSString * const kRZSettingsFileTitle = @"Settings";
static NSString * const kRZSettingsFileExtension = @"plist";

@interface RZDebugMenu ()

@end

@implementation RZDebugMenu

-(id)init
{
    @throw [NSException exceptionWithName:@"Illegal allocation of setup interface"
                                   reason:@"You can't instantiate RZDebugMenu. Only method is + (void)enable"
                                 userInfo:nil];
}

+ (void)enable
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:kRZSettingsFileTitle ofType:kRZSettingsFileExtension];
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    RZDebugMenuSettingsInterface *debugSettingsInterface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
    RZDebugMenuModalViewController *modalViewController = [[RZDebugMenuModalViewController alloc] initWithInterface:debugSettingsInterface];
    RZDebugMenuDummyViewController *dummyViewController = [[RZDebugMenuDummyViewController alloc] init];
    
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *applicationWindow = application.delegate.window;
    
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:dummyViewController action:@selector(showDebugMenu)];
    
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [applicationWindow addGestureRecognizer:tripleTap];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:mainScreen.bounds];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    window.rootViewController = modalViewController;
    window.backgroundColor = [UIColor redColor];
    window.windowLevel = UIWindowLevelAlert;
    
    [applicationWindow addSubview:window];
}

@end
