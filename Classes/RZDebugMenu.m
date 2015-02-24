//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

#import "RZDebugMenuWindow.h"

#import "RZDebugMenuSettings.h"
#import "RZDebugMenuSettingsForm.h"
#import "RZDebugMenuSettingsParser.h"
#import "RZDebugMenuChildPaneItem.h"
#import "RZDebugMenuLoadedChildPaneItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuFormViewController.h"
#import "RZDebugMenuSettings_Private.h"

#import "RZDebugLogMenuDefines.h"

#import <FXForms/FXForms.h>

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";

static NSUInteger kRZNumberOfTapsToHide = 4;

@interface RZDebugMenu () <RZDebugMenuClearViewControllerDelegate>

@property (strong, nonatomic) RZDebugMenuWindow *topWindow;
@property (strong, nonatomic) RZDebugMenuClearViewController *clearRootViewController;

@property (strong, nonatomic, readwrite) NSArray *settingsMenuItems;

@end

@implementation RZDebugMenu

#pragma mark - Public API

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

# pragma mark - Lifecycle

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
                                                 selector:@selector(applicationDidFinishLaunching:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];

        self.showDebugMenuButton = NO;
    }

    return self;
}

# pragma mark - Configuration

- (void)configureTopWindow
{
    self.clearRootViewController = [[RZDebugMenuClearViewController alloc] initWithDelegate:self];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    self.topWindow = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
    self.topWindow.windowLevel = UIWindowLevelStatusBar - 1.f;
    self.topWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.topWindow.rootViewController = self.clearRootViewController;
    self.topWindow.hidden = NO;
}

#pragma mark - UX

- (void)displayDebugMenu
{
    if ( self.settingsMenuItems.count > 0 ) {
        RZDebugMenuSettingsForm *settingsForm = [[RZDebugMenuSettingsForm alloc] initWithSettingsMenuItems:self.settingsMenuItems];

        FXFormViewController *settingsMenuViewController = [[RZDebugMenuFormViewController alloc] init];
        settingsMenuViewController.formController.form = settingsForm;

        UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenuViewController];
        [self.clearRootViewController presentViewController:modalNavigationController animated:YES completion:nil];
    }
}

#pragma mark - RZDebugMenuClearViewControllerDelegate

- (void)clearViewControllerDebugMenuButtonPressed:(RZDebugMenuClearViewController *)clearViewController
{
    [self displayDebugMenu];
}

#pragma mark - Notifications

- (void)applicationDidFinishLaunching:(NSNotification *)note
{
    [self configureTopWindow];
}

#pragma mark - Settings Menu

- (void)loadSettingsMenuFromPlistName:(NSString *)plistName
{
    NSError *settingsParsingError = nil;
    NSArray *keys = nil;
    NSDictionary *defaultValues = nil;

    NSArray *settingsMenuItems = [RZDebugMenuSettingsParser settingsMenuItemsFromPlistName:plistName
                                                                             returningKeys:&keys
                                                                             defaultValues:&defaultValues
                                                                                     error:&settingsParsingError];
    if ( settingsMenuItems ) {
        // We've loaded all our settings. Initialize the store.
        [RZDebugMenuSettings initializeWithKeys:keys defaultValues:defaultValues];
    }
    else {
        NSLog(@"Failed to parse settings from plist %@: %@.", plistName, settingsParsingError);
    }

    self.settingsMenuItems = settingsMenuItems;
}

# pragma mark - Show / Hide

- (void)configureAutomaticShowHideOnWindow:(UIWindow *)window
{
    NSAssert(window != nil, @"");

    UIViewController *rootViewController = window.rootViewController;
    NSAssert(rootViewController != nil, @"");

    UIView *view = rootViewController.view;
    NSAssert(view != nil, @"");

    UITapGestureRecognizer *manyTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manyTapGestureRecognizerFired:)];
    manyTapGestureRecognizer.numberOfTapsRequired = kRZNumberOfTapsToHide;

    [view addGestureRecognizer:manyTapGestureRecognizer];
}

- (void)manyTapGestureRecognizerFired:(id)sender
{
    [self showHideDebugMenuButton];
}

- (void)showHideDebugMenuButton
{
    self.clearRootViewController.showDebugMenuButton = (!self.clearRootViewController.showDebugMenuButton);
}

- (void)setShowDebugMenuButton:(BOOL)showDebugMenuButton
{
    if ( _showDebugMenuButton != showDebugMenuButton ) {
        _showDebugMenuButton = showDebugMenuButton;

        self.clearRootViewController.showDebugMenuButton = showDebugMenuButton;
    }
}

@end
