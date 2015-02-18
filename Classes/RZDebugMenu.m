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
#import "RZDebugMenuSettingsObserverManager.h"
#import "RZDebugMenuSettingsForm.h"
#import "RZDebugMenuSettingsParser.h"

#import "RZDebugLogMenuDefines.h"

#import <FXForms/FXForms.h>

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";
static NSString * const kRZSettingsFileExtension       = @"plist";

@interface RZDebugMenu () <UIGestureRecognizerDelegate, RZDebugMenuClearViewControllerDelegate>

@property (strong, nonatomic) RZDebugMenuWindow *topWindow;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeUpGesture;
@property (strong, nonatomic) RZDebugMenuClearViewController *clearRootViewController;
@property (assign, nonatomic) BOOL enabled;

@property (strong, nonatomic, readwrite) NSArray *settingsModels;

@end

@implementation RZDebugMenu

#pragma mark - class methods

+ (instancetype)sharedDebugMenu
{
    static RZDebugMenu *s_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[RZDebugMenu alloc] init_internal];
    });

    return s_sharedInstance;
}

+ (void)enableMenuWithSettingsPlistName:(NSString *)plistName
{
    [[self sharedDebugMenu] loadSettingsMenuFromPlistName:plistName];
    [[self sharedDebugMenu] setEnabled:YES];
}

+ (id)debugSettingForKey:(NSString *)key
{
    return [RZDebugMenuSettingsInterface valueForDebugSettingsKey:key];
}

+ (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key updateImmediately:(BOOL)update
{
    [[RZDebugMenuSettingsObserverManager sharedInstance] addObserver:observer
                                                            selector:aSelector
                                                              forKey:key
                                                   updateImmediately:update];
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
    if ( self.settingsModels.count > 0 ) {
        RZDebugMenuSettingsForm *settingsForm = [[RZDebugMenuSettingsForm alloc] initWithSettingsModels:self.settingsModels];

        FXFormViewController *settingsMenuViewController = [[FXFormViewController alloc] init];
        settingsMenuViewController.formController.form = settingsForm;

        UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenuViewController];
        [self.clearRootViewController presentViewController:modalNavigationController animated:YES completion:nil];
    }
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

+ (NSArray *)settingsModelsFromPlistName:(NSString *)plistName error:(NSError * __autoreleasing *)outError
{
    plistName = [plistName stringByDeletingPathExtension];

    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:plistName withExtension:kRZSettingsFileExtension];
    if ( !plistURL ) {
        NSString *exceptionName = [plistName stringByAppendingString:@".plist doesn't exist"];
        @throw [NSException exceptionWithName:exceptionName
                                       reason:@"Make sure you have a settings plist file in the Resources directory of your application"
                                     userInfo:nil];
    }

    NSArray *settingsModels = nil;

    NSError *dataReadingError = nil;
    NSData *plistData = [NSData dataWithContentsOfURL:plistURL options:0 error:&dataReadingError];
    if ( plistData ) {
        NSError *dataParsingError = nil;
        NSDictionary *propertyListDictionary = [NSPropertyListSerialization propertyListWithData:plistData options:0 format:NULL error:&dataParsingError];
        if ( propertyListDictionary ) {
            NSAssert([propertyListDictionary isKindOfClass:[NSDictionary class]], @"");

            NSError *modelParsingError = nil;
            settingsModels = [RZDebugMenuSettingsParser modelsFromSettingsDictionary:propertyListDictionary error:&modelParsingError];
        }
    }

    return settingsModels;
}

- (void)loadSettingsMenuFromPlistName:(NSString *)plistName
{
    NSError *settingsParsingError = nil;
    NSArray *settingsModels = [[self class] settingsModelsFromPlistName:plistName error:&settingsParsingError];
    if ( settingsModels ) {
    }
    else {
        NSLog(@"Failed to parse settings from plist %@: %@.", plistName, settingsParsingError);
    }

    self.settingsModels = settingsModels;
}

@end
