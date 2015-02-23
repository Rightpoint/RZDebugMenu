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
#import "RZDebugMenuChildPaneItem.h"
#import "RZDebugMenuLoadedChildPaneItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuFormViewController.h"

#import "RZDebugLogMenuDefines.h"

#import <FXForms/FXForms.h>

NSString* const kRZDebugMenuSettingChangedNotification = @"RZDebugMenuSettingChanged";
static NSString * const kRZSettingsFileExtension       = @"plist";

@interface RZDebugMenu () <RZDebugMenuClearViewControllerDelegate>

@property (strong, nonatomic) RZDebugMenuWindow *topWindow;
@property (strong, nonatomic) RZDebugMenuClearViewController *clearRootViewController;
@property (assign, nonatomic) BOOL enabled;

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

# pragma mark - Settings

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

+ (NSArray *)settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:(NSArray *)settingsMenuItems error:(NSError * __autoreleasing *)outError
{
    NSError *errorToReturn = nil;
    NSMutableArray *mutableSettingsMenuItemsToReturn = [settingsMenuItems mutableCopy];

    for ( RZDebugMenuItem *menuItem in settingsMenuItems ) {
        if ( [menuItem isKindOfClass:[RZDebugMenuChildPaneItem class]] ) {
            NSString *plistName = ((RZDebugMenuChildPaneItem *)menuItem).plistName;

            NSError *childPaneParsingError = nil;
            NSArray *childPaneSettingsMenuItems = [[self class] settingsMenuItemsFromPlistName:plistName error:&childPaneParsingError];
            if ( childPaneSettingsMenuItems ) {
                RZDebugMenuLoadedChildPaneItem *loadedChildPaneItem = [[RZDebugMenuLoadedChildPaneItem alloc] initWithTitle:menuItem.title plistName:plistName settingsMenuItems:childPaneSettingsMenuItems];
                NSUInteger index = [mutableSettingsMenuItemsToReturn indexOfObject:menuItem];
                [mutableSettingsMenuItemsToReturn replaceObjectAtIndex:index withObject:loadedChildPaneItem];
            }
            else {
                errorToReturn = childPaneParsingError;
                break;
            }
        }
        else if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            RZDebugMenuGroupItem *groupItem = (RZDebugMenuGroupItem *)menuItem;
            NSArray *childSettingsMenuItems = groupItem.children;

            NSError *recursiveLoadingError = nil;
            childSettingsMenuItems = [self settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:childSettingsMenuItems error:&recursiveLoadingError];

            if ( childSettingsMenuItems ) {
                groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:groupItem.title children:childSettingsMenuItems];
                NSUInteger index = [mutableSettingsMenuItemsToReturn indexOfObject:menuItem];
                [mutableSettingsMenuItemsToReturn replaceObjectAtIndex:index withObject:groupItem];
            }
            else {
                errorToReturn = recursiveLoadingError;
                break;
            }
        }
    }

    if ( errorToReturn ) {
        mutableSettingsMenuItemsToReturn = nil;
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return [mutableSettingsMenuItemsToReturn copy];
}

+ (NSArray *)settingsMenuItemsFromPlistName:(NSString *)plistName error:(NSError * __autoreleasing *)outError
{
    plistName = [plistName stringByDeletingPathExtension];

    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:plistName withExtension:kRZSettingsFileExtension];
    if ( !plistURL ) {
        NSString *exceptionName = [plistName stringByAppendingString:@".plist doesn't exist"];
        @throw [NSException exceptionWithName:exceptionName
                                       reason:@"Make sure you have a settings plist file in the Resources directory of your application"
                                     userInfo:nil];
    }

    NSArray *settingsMenuItems = nil;
    NSError *errorToReturn = nil;

    NSError *dataReadingError = nil;
    NSData *plistData = [NSData dataWithContentsOfURL:plistURL options:0 error:&dataReadingError];
    if ( plistData ) {
        NSError *dataParsingError = nil;
        NSDictionary *propertyListDictionary = [NSPropertyListSerialization propertyListWithData:plistData options:0 format:NULL error:&dataParsingError];
        if ( propertyListDictionary ) {
            NSAssert([propertyListDictionary isKindOfClass:[NSDictionary class]], @"");

            NSError *settingsMenuItemsParsingError = nil;
            settingsMenuItems = [RZDebugMenuSettingsParser settingsMenuItemsFromSettingsDictionary:propertyListDictionary error:&settingsMenuItemsParsingError];
            if ( settingsMenuItems ) {
                NSError *recursiveLoadingError = nil;
                settingsMenuItems = [self settingsMenuItemsByRecursivelyLoadingChildPanesFromSettingsMenuItems:settingsMenuItems error:&recursiveLoadingError];
                if ( settingsMenuItems == nil ) {
                    errorToReturn = recursiveLoadingError;
                }
            }
            else {
                errorToReturn = settingsMenuItemsParsingError;
            }
        }
        else {
            errorToReturn = dataParsingError;
        }
    }
    else {
        errorToReturn = dataReadingError;
    }

    if ( errorToReturn ) {
        settingsMenuItems = nil;
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return settingsMenuItems;
}

- (void)loadSettingsMenuFromPlistName:(NSString *)plistName
{
    NSError *settingsParsingError = nil;
    NSArray *settingsMenuItems = [[self class] settingsMenuItemsFromPlistName:plistName error:&settingsParsingError];
    if ( settingsMenuItems ) {
        // Nothing to do here.
    }
    else {
        NSLog(@"Failed to parse settings from plist %@: %@.", plistName, settingsParsingError);
    }

    self.settingsMenuItems = settingsMenuItems;
}

@end
