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

#import "RZDebugMenuModalViewController.h"

static NSString * const kRZSettingsFileTitle = @"Settings";
static NSString * const kRZSettingsFileExtension = @"plist";

@interface RZDebugMenu ()

@property (strong, nonatomic) RZDebugMenuSettingsInterface *interface;
@property (strong, nonatomic) RZDebugMenuWindow *topWindow;
@property (strong, nonatomic) UITapGestureRecognizer *tripleTapGesture;
@property (strong, nonatomic) UIViewController *clearRootViewController;
@property (assign, nonatomic) BOOL enabled;

@end

@implementation RZDebugMenu

+ (instancetype)privateSharedInstance
{
    static RZDebugMenu *s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[RZDebugMenu alloc] init_internal];
    });
    return s_sharedInstance;
}

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"You can't instantiate RZDebugMenu. Only method is + (void)enable"
                                 userInfo:nil];
}

- (RZDebugMenu *)init_internal
{
    self = [super init];
    if ( self ) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attachGesture:) name:UIApplicationDidFinishLaunchingNotification object:nil];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:kRZSettingsFileTitle ofType:kRZSettingsFileExtension];
        if ( !plistPath ) {
            @throw [NSException exceptionWithName:@"Settings.plist doesn't exist"
                                           reason:@"Make sure you have a 'Settings.plist' file in the Resources directory of your application"
                                         userInfo:nil];
        }
        
        NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _interface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
        _clearRootViewController = [[UIViewController alloc] init];
        _clearRootViewController.view.backgroundColor = [UIColor clearColor];
        
        UIScreen *mainScreen = [UIScreen mainScreen];
        _topWindow = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
        _topWindow.windowLevel = UIWindowLevelStatusBar - 1.0;
        _topWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _topWindow.rootViewController = _clearRootViewController;
        _topWindow.hidden = NO;
    }
    return self;
}

+ (void)enable
{
    [[self privateSharedInstance] setEnabled:YES];
}

- (void)showDebugMenu
{
    RZDebugMenuModalViewController *settingsMenu = [[RZDebugMenuModalViewController alloc] initWithInterface:self.interface];
    UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenu];
    [self.clearRootViewController presentViewController:modalNavigationController animated:YES completion:nil];
}

- (void)attachGesture:(NSNotification *)message
{
    UIApplication *application = [UIApplication sharedApplication];
    self.tripleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDebugMenu)];
    self.tripleTapGesture.numberOfTapsRequired = 3;
    self.tripleTapGesture.numberOfTouchesRequired = 1;
    UIWindow *applicationWindow = application.keyWindow;
    self.tripleTapGesture.delegate = self;
    [applicationWindow addGestureRecognizer:self.tripleTapGesture];
}

#pragma mark - gesture recognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
