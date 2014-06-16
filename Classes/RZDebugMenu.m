//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"
#import "RZDebugMenuSharedManager.h"
#import "RZDebugMenuWindow.h"
#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuSettingsInterface.h"

static NSString * const kRZSettingsFileTitle = @"Settings";
static NSString * const kRZSettingsFileExtension = @"plist";

@interface RZDebugMenu ()

@property(nonatomic, strong) RZDebugMenuSharedManager *sharedManager;

- (void)initSharedManager;

@end

@implementation RZDebugMenu

-(id)init
{
    @throw [NSException exceptionWithName:@"Illegal allocation of setup interface"
                                   reason:@"You can't instantiate RZDebugMenu. Only method is + (void)enable"
                                 userInfo:nil];
}

- (void)initSharedManager
{
    _sharedManager = [RZDebugMenuSharedManager sharedTopLevel];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:kRZSettingsFileTitle ofType:kRZSettingsFileExtension];
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    RZDebugMenuSettingsInterface *debugSettingsInterface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
    RZDebugMenuDummyViewController *dummyViewController = [[RZDebugMenuDummyViewController alloc] initWithInterface:debugSettingsInterface];
    dummyViewController.view.backgroundColor = [UIColor clearColor];
    
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *applicationWindow = application.keyWindow;
    
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:_sharedManager action:@selector(showDebugMenu)];
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    
    [applicationWindow addGestureRecognizer:tripleTap];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    RZDebugMenuWindow *window = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    window.rootViewController = dummyViewController;
    window.hidden = NO;
    
    _sharedManager.topWindow = window;
    _sharedManager.tripleTap = tripleTap;
    _sharedManager.clearViewController = dummyViewController;
}

+ (void)enable
{
    [[self alloc] initSharedManager];
}

@end
