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

@property (strong, nonatomic, readwrite) NSArray *settingsModels;

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
    if ( self.settingsModels.count > 0 ) {
        RZDebugMenuSettingsForm *settingsForm = [[RZDebugMenuSettingsForm alloc] initWithSettingsModels:self.settingsModels];

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

+ (NSArray *)settingsModelsByRecursivelyLoadingChildPanesFromSettingsModels:(NSArray *)settingsModels error:(NSError * __autoreleasing *)outError
{
    NSError *errorToReturn = nil;
    NSMutableArray *mutableSettingsModelsToReturn = [settingsModels mutableCopy];

    for ( RZDebugMenuItem *menuItem in settingsModels ) {
        if ( [menuItem isKindOfClass:[RZDebugMenuChildPaneItem class]] ) {
            NSString *plistName = ((RZDebugMenuChildPaneItem *)menuItem).plistName;

            NSError *childPaneParsingError = nil;
            NSArray *childPaneSettignsModels = [[self class] settingsModelsFromPlistName:plistName error:&childPaneParsingError];
            if ( childPaneSettignsModels ) {
                RZDebugMenuLoadedChildPaneItem *loadedChildPaneItem = [[RZDebugMenuLoadedChildPaneItem alloc] initWithTitle:menuItem.title plistName:plistName settingsModels:childPaneSettignsModels];
                NSUInteger index = [mutableSettingsModelsToReturn indexOfObject:menuItem];
                [mutableSettingsModelsToReturn replaceObjectAtIndex:index withObject:loadedChildPaneItem];
            }
            else {
                errorToReturn = childPaneParsingError;
                break;
            }
        }
        else if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            RZDebugMenuGroupItem *groupItem = (RZDebugMenuGroupItem *)menuItem;
            NSArray *childSettingsModels = groupItem.children;

            NSError *recursiveLoadingError = nil;
            childSettingsModels = [self settingsModelsByRecursivelyLoadingChildPanesFromSettingsModels:childSettingsModels error:&recursiveLoadingError];

            if ( childSettingsModels ) {
                groupItem = [[RZDebugMenuGroupItem alloc] initWithTitle:groupItem.title children:childSettingsModels];
                NSUInteger index = [mutableSettingsModelsToReturn indexOfObject:menuItem];
                [mutableSettingsModelsToReturn replaceObjectAtIndex:index withObject:groupItem];
            }
            else {
                errorToReturn = recursiveLoadingError;
                break;
            }
        }
    }

    if ( errorToReturn ) {
        mutableSettingsModelsToReturn = nil;
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return [mutableSettingsModelsToReturn copy];
}

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
    NSError *errorToReturn = nil;

    NSError *dataReadingError = nil;
    NSData *plistData = [NSData dataWithContentsOfURL:plistURL options:0 error:&dataReadingError];
    if ( plistData ) {
        NSError *dataParsingError = nil;
        NSDictionary *propertyListDictionary = [NSPropertyListSerialization propertyListWithData:plistData options:0 format:NULL error:&dataParsingError];
        if ( propertyListDictionary ) {
            NSAssert([propertyListDictionary isKindOfClass:[NSDictionary class]], @"");

            NSError *modelParsingError = nil;
            settingsModels = [RZDebugMenuSettingsParser modelsFromSettingsDictionary:propertyListDictionary error:&modelParsingError];
            if ( settingsModels ) {
                NSError *recursiveLoadingError = nil;
                settingsModels = [self settingsModelsByRecursivelyLoadingChildPanesFromSettingsModels:settingsModels error:&recursiveLoadingError];
                if ( settingsModels == nil ) {
                    errorToReturn = recursiveLoadingError;
                }
            }
            else {
                errorToReturn = modelParsingError;
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
        settingsModels = nil;
    }

    if ( outError ) {
        *outError = errorToReturn;
    }

    return settingsModels;
}

- (void)loadSettingsMenuFromPlistName:(NSString *)plistName
{
    NSError *settingsParsingError = nil;
    NSArray *settingsModels = [[self class] settingsModelsFromPlistName:plistName error:&settingsParsingError];
    if ( settingsModels ) {
        // Nothing to do here.
    }
    else {
        NSLog(@"Failed to parse settings from plist %@: %@.", plistName, settingsParsingError);
    }

    self.settingsModels = settingsModels;
}

@end
