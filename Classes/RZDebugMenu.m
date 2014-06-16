//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

#import "RZDebugMenuWindow.h"
#import "RZDebugMenuSettingsInterface.h"

#import "RZDebugMenuDummyViewController.h"
#import "RZDebugMenuModalViewController.h"

static NSString * const kRZSettingsFileTitle = @"Settings";
static NSString * const kRZSettingsFileExtension = @"plist";

@interface RZDebugMenu ()

@property(strong, nonatomic) RZDebugMenuWindow *topWindow;
@property(strong, nonatomic) UITapGestureRecognizer *tripleTapGesture;
@property(strong, nonatomic) RZDebugMenuDummyViewController *clearRootViewController;

@end

@implementation RZDebugMenu

+ (instancetype)privateSharedInstance {
    static RZDebugMenu *s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[RZDebugMenu alloc] init_internal];
    });
    return s_sharedInstance;
}

- (id)init
{
    @throw [NSException exceptionWithName:@"Illegal allocation of setup interface"
                                   reason:@"You can't instantiate RZDebugMenu. Only method is + (void)enable"
                                 userInfo:nil];
}

- (RZDebugMenu *)init_internal
{
    self = [super init];
    if ( self ) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:kRZSettingsFileTitle ofType:kRZSettingsFileExtension];
        NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        RZDebugMenuSettingsInterface *debugSettingsInterface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
        _clearRootViewController = [[RZDebugMenuDummyViewController alloc] initWithInterface:debugSettingsInterface];
        _clearRootViewController.view.backgroundColor = [UIColor clearColor];
        
        UIApplication *application = [UIApplication sharedApplication];
        UIWindow *applicationWindow = application.keyWindow;
        _tripleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDebugMenu)];
        _tripleTapGesture.numberOfTapsRequired = 3;
        _tripleTapGesture.numberOfTouchesRequired = 1;
        [applicationWindow addGestureRecognizer:_tripleTapGesture];
        
        UIScreen *mainScreen = [UIScreen mainScreen];
        _topWindow = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
        _topWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _topWindow.rootViewController = _clearRootViewController;
        _topWindow.hidden = NO;
    }
    return self;
}

+ (void)enable
{
    [self privateSharedInstance];
}

- (void)showDebugMenu
{
    RZDebugMenuModalViewController *settingsMenu = [[RZDebugMenuModalViewController alloc] initWithInterface:self.clearRootViewController.interface];
    UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenu];
    [self.clearRootViewController presentViewController:modalNavigationController animated:YES completion:nil];
}

@end
