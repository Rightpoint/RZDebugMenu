//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

#import "RZDebugMenuWindow.h"
#import "RZDebugMenuModalViewController.h"

#import "RZDebugMenuSettingsInterface.h"
#import "RZDebugMenuSettingsDataSource.h"
#import "RZDebugMenuSettingsObserverManager.h"

#import "RZDebugLogMenuDefines.h"

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";
static NSString * const kRZSettingsFileExtension       = @"plist";

@interface RZDebugMenu () <UIGestureRecognizerDelegate, RZDebugMenuClearViewControllerDelegate>

@property (strong, nonatomic) RZDebugMenuWindow *topWindow;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeUpGesture;
@property (strong, nonatomic) RZDebugMenuClearViewController *clearRootViewController;
@property (strong, nonatomic) RZDebugMenuSettingsDataSource *settingsTableViewDataSource;
@property (copy, nonatomic) NSString *settingsFileName;
@property (assign, nonatomic) BOOL enabled;

@end

@implementation RZDebugMenu

#pragma mark - class methods

+ (instancetype)privateSharedInstance
{
    static RZDebugMenu *s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[RZDebugMenu alloc] init_internal];
    });

    return s_sharedInstance;
}

+ (void)enableWithSettingsPlist:(NSString *)fileName
{
    [[self privateSharedInstance] setSettingsFileName:fileName];
    [[self privateSharedInstance] setEnabled:YES];
}

+ (id)debugSettingForKey:(NSString *)key
{
    return [RZDebugMenuSettingsInterface valueForDebugSettingsKey:key];
}

+ (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key updateImmediately:(BOOL)update
{
    RZDebugMenu *sharedInstance = [self privateSharedInstance];

    if ( ![sharedInstance.settingsTableViewDataSource.settingsKeys containsObject:key] ) {
        RZDebugMenuLogDebug("Warning! Key not in plist");
    }
    else {
        
        [[RZDebugMenuSettingsObserverManager sharedInstance] addObserver:observer
                                                                selector:aSelector
                                                                  forKey:key
                                                       updateImmediately:update];
    }
}

+ (void)removeObserver:(id)observer forKey:(NSString *)key
{
    [[RZDebugMenuSettingsObserverManager sharedInstance] removeObserver:observer forKey:key];
}

#pragma mark - initialize methods

- (id)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"RZDebugMenu cannot be instantiated. Please use the class method interface."
                                 userInfo:nil];
}

- (RZDebugMenu *)init_internal
{
    self = [super init];
    if ( self ) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(createWindowAndGesture:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }

    return self;
}

- (void)createWindowAndGesture:(NSNotification *)message
{
    if ( self.enabled ) {
        
        [self createTopWindow];
        [self createSwipeGesture];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changeOrientation)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
}

- (void)createTopWindow
{
    self.clearRootViewController = [[RZDebugMenuClearViewController alloc] initWithDelegate:self];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    self.topWindow = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
    self.topWindow.windowLevel = UIWindowLevelStatusBar - 1.f;
    self.topWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.topWindow.rootViewController = self.clearRootViewController;
    self.topWindow.hidden = NO;
}

- (void)createSwipeGesture
{
    UIApplication *application = [UIApplication sharedApplication];
    self.swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(displayDebugMenu)];
    self.swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    self.swipeUpGesture.numberOfTouchesRequired = 3;
    self.swipeUpGesture.delegate = self;
    UIWindow *applicationWindow = application.keyWindow;
    [applicationWindow addGestureRecognizer:self.swipeUpGesture];
}

#pragma mark - state change methods

- (void)displayDebugMenu
{
    RZDebugMenuModalViewController *settingsMenu = [[RZDebugMenuModalViewController alloc] initWithDataSource:self.settingsTableViewDataSource];
    UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenu];
    [self.clearRootViewController presentViewController:modalNavigationController animated:YES completion:nil];
}

- (void)changeOrientation
{
    CGFloat const iOSOrientationDepricationVersion = 8.0;
    NSString *systemVersionString = [[[UIDevice currentDevice] systemVersion] substringToIndex:3];
    CGFloat systemVersion = [systemVersionString floatValue];

    if ( systemVersion < iOSOrientationDepricationVersion ) {
        
        UIInterfaceOrientation statusBarOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if ( statusBarOrientation == UIDeviceOrientationLandscapeLeft ) {
            self.swipeUpGesture.direction = UISwipeGestureRecognizerDirectionRight;
        }
        else if ( statusBarOrientation == UIDeviceOrientationLandscapeRight ) {
            self.swipeUpGesture.direction = UISwipeGestureRecognizerDirectionLeft;
        }
        else if ( statusBarOrientation == UIDeviceOrientationPortraitUpsideDown ) {
            self.swipeUpGesture.direction = UISwipeGestureRecognizerDirectionDown;
        }
        else {
            self.swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
        }
    }
}

#pragma mark - RZDebugMenuClearViewControllerDelegate

- (void)clearViewControllerDebugMenuButtonPressed:(RZDebugMenuClearViewController *)clearViewController
{
    [self displayDebugMenu];
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

#pragma mark - Accessors

- (void)setSettingsFileName:(NSString *)settingsFileName
{
    _settingsFileName = settingsFileName;
    _settingsFileName = [_settingsFileName stringByDeletingPathExtension];

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:_settingsFileName ofType:kRZSettingsFileExtension];
    
    if ( !plistPath ) {
        
        NSString *exceptionName = [_settingsFileName stringByAppendingString:@".plist doesn't exist"];
        @throw [NSException exceptionWithName:exceptionName
                                       reason:@"Make sure you have a settings plist file in the Resources directory of your application"
                                     userInfo:nil];
    }
    
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    _settingsTableViewDataSource = [[RZDebugMenuSettingsDataSource alloc] initWithDictionary:plistData];
}

@end
