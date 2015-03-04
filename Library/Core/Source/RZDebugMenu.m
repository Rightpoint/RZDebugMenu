//
//  RZDebugMenu.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenu.h"

#import "RZDebugMenuSettings.h"
#import "RZDebugMenuForm.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuFormViewController.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuChildItem.h"
#import "UIViewController+RZDebugMenuPresentationAdditions.h"
#import "RZDebugLogMenuDefines.h"
#import "RZDebugMenuViewControllerItem.h"

#import <FXForms/FXForms.h>

static NSString *const kRZVersionTitle = @"Version";

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";

static NSUInteger kRZNumberOfTapsToShow = 3;
static NSUInteger kRZNumberOfTouchesToShow = 2;

@interface RZDebugMenu () <RZDebugMenuFormViewControllerDelegate>

@property (strong, nonatomic, readwrite) UIViewController *debugMenuViewControllerToPresent;

@property (strong, nonatomic, readwrite) NSArray *topLevelMenuItems;

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
        self.topLevelMenuItems = [NSArray array];
    }

    return self;
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

    if ( self.topLevelMenuItems.count > 0 ) {
        RZDebugMenuForm *settingsForm = [[RZDebugMenuForm alloc] initWithMenuItems:self.topLevelMenuItems];

        RZDebugMenuFormViewController *settingsMenuViewController = [[RZDebugMenuFormViewController alloc] init];
        settingsMenuViewController.delegate = self;

        settingsForm.delegate = settingsMenuViewController;

        settingsMenuViewController.formController.form = settingsForm;

        UINavigationController *modalNavigationController = [[UINavigationController alloc] initWithRootViewController:settingsMenuViewController];

        self.debugMenuViewControllerToPresent = modalNavigationController;
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

# pragma mark - Menulets

- (void)appendMenuItems:(NSArray *)menuItems
{
    NSAssert(menuItems.count > 0, @"");

    NSMutableArray *mutableTopLevelMenuItems = [self.topLevelMenuItems mutableCopy];
    [mutableTopLevelMenuItems addObjectsFromArray:menuItems];
    self.topLevelMenuItems = [mutableTopLevelMenuItems copy];
}

- (void)addMenulet:(id <RZDebugMenulet>)menulet
{
    NSString *title = menulet.title;

    NSArray *menuItems = nil;
    if ( [menulet respondsToSelector:@selector(menuItems)] ) {
        menuItems = menulet.menuItems;
    }

    if ( menuItems.count > 0 ) {
        RZDebugMenuChildItem *childItem = [[RZDebugMenuChildItem alloc] initWithTitle:title children:menuItems];
        [self appendMenuItems:@[childItem]];
    }

    UIViewController *viewController = nil;
    if ( [menulet respondsToSelector:@selector(viewController)] ) {
        viewController = menulet.viewController;
    }

    if ( viewController ) {
        RZDebugMenuItem *viewControllerMenuItem = [[RZDebugMenuViewControllerItem alloc] initWithTitle:title viewController:viewController];
        [self appendMenuItems:@[viewControllerMenuItem]];
    }
}

- (void)appendMenulet:(id <RZDebugMenulet>)menulet
{
    NSString *title = menulet.title;

    NSArray *menuItems = nil;
    if ( [menulet respondsToSelector:@selector(menuItems)] ) {
        menuItems = menulet.menuItems;
    }
    
    if ( menuItems.count > 0 ) {
        RZDebugMenuGroupItem *groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:title children:menuItems];
        [self appendMenuItems:@[groupItem]];
    }

    UIViewController *viewController = nil;
    if ( [menulet respondsToSelector:@selector(viewController)] ) {
        viewController = menulet.viewController;
    }

    if ( viewController ) {
        RZDebugMenuItem *viewControllerMenuItem = [[RZDebugMenuViewControllerItem alloc] initWithTitle:title viewController:viewController];
        [self appendMenuItems:@[viewControllerMenuItem]];
    }
}

@end
