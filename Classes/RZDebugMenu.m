//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

#import "RZDebugMenuSettings.h"
#import "RZDebugMenuSettingsForm.h"
#import "RZDebugMenuSettingsParser.h"
#import "RZDebugMenuSettingsBundleChildItem.h"
#import "RZDebugMenuLoadedSettingsBundleChildItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuFormViewController.h"
#import "RZDebugMenuSettings_Private.h"
#import "RZDebugMenuVersionItem.h"
#import "RZDebugMenuGroupItem.h"
#import "UIViewController+RZDebugMenuPresentationAdditions.h"

#import "RZDebugLogMenuDefines.h"

#import <FXForms/FXForms.h>

static NSString *const kRZVersionTitle = @"Version";

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";

static NSUInteger kRZNumberOfTapsToShow = 3;
static NSUInteger kRZNumberOfTouchesToShow = 2;

@interface RZDebugMenu () <RZDebugMenuFormViewControllerDelegate>

@property (strong, nonatomic, readwrite) UIViewController *debugMenuViewControllerToPresent;

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
}

# pragma mark - Lifecycle

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"RZDebugMenu cannot be instantiated. Please use the class method interface."
                                 userInfo:nil];
}

- (RZDebugMenu *)init_internal
{
    self = [super init];
    if ( self ) {
        [self configureDebugMenu];
    }

    return self;
}

#pragma mark - Configuration

- (void)configureDebugMenu
{
    if ( self.settingsMenuItems.count > 0 ) {
        RZDebugMenuSettingsForm *settingsForm = [[RZDebugMenuSettingsForm alloc] initWithMenuItems:self.settingsMenuItems];

        RZDebugMenuFormViewController *settingsMenuViewController = [[RZDebugMenuFormViewController alloc] init];
        settingsMenuViewController.delegate = self;
        
        settingsForm.delegate = settingsMenuViewController;

        settingsMenuViewController.formController.form = settingsForm;

        UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenuViewController];

        self.debugMenuViewControllerToPresent = modalNavigationController;
    }
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

    if ( settingsMenuItems ) {
        RZDebugMenuVersionItem *versionItem = [[RZDebugMenuVersionItem alloc] init];
        RZDebugMenuGroupItem *versionGroupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:kRZVersionTitle children:@[versionItem]];
        settingsMenuItems = [settingsMenuItems arrayByAddingObject:versionGroupItem];
    }

    self.settingsMenuItems = settingsMenuItems;

    [self configureDebugMenu];
}

# pragma mark - Presentation

- (void)registerDebugMenuPresentationGestureOnView:(UIView *)view
{
    NSAssert(view != nil, @"");

    UITapGestureRecognizer *manyTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(debugMenuActivationGestureRecognizerFired:)];
    manyTapGestureRecognizer.numberOfTapsRequired = kRZNumberOfTapsToShow;
    manyTapGestureRecognizer.numberOfTouchesRequired = kRZNumberOfTouchesToShow;

    [view addGestureRecognizer:manyTapGestureRecognizer];
}

- (void)presentDebugMenu
{
    if ( self.debugMenuViewControllerToPresent.presentingViewController != nil ) {
        NSLog(@"Not presenting debug menu. It is already active.");
        return;
    }

    if ( self.debugMenuViewControllerToPresent == nil ) {
        NSLog(@"No debug menu enabled. Not presenting.");
        return;
    }

    UIViewController *viewControllerToPresentOn = [UIApplication sharedApplication].keyWindow.rootViewController;
    viewControllerToPresentOn = viewControllerToPresentOn.rzDebugMenu_deepestViewControllerForPresentation;

    [viewControllerToPresentOn presentViewController:self.debugMenuViewControllerToPresent animated:YES completion:nil];
}

- (void)debugMenuActivationGestureRecognizerFired:(id)sender
{
    [self presentDebugMenu];
}

- (void)dismissDebugMenu
{
    if ( self.debugMenuViewControllerToPresent.presentingViewController ) {
        [self.debugMenuViewControllerToPresent dismissViewControllerAnimated:YES completion:nil];
    }
}

# pragma mark - RZDebugMenuFormViewControllerDelegate

- (void)debugMenuFormViewControllerShouldDimiss:(RZDebugMenuFormViewController *)debugMenuFormViewController
{
    [self dismissDebugMenu];
}

@end
