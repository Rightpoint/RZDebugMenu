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
#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuSettingsInterface.h"

static NSString * const kRZSettingsFileTitle = @"Settings";
static NSString * const kRZSettingsFileExtension = @"plist";

@interface RZDebugMenu ()

@property(nonatomic, strong) RZDebugMenuSharedManager *sharedManager;

@end

@implementation RZDebugMenu

-(id)init
{
    @throw [NSException exceptionWithName:@"Illegal allocation of setup interface"
                                   reason:@"You can't instantiate RZDebugMenu. Only method is + (void)enable"
                                 userInfo:nil];
}

//- (id)initWithWindow:(RZDebugMenuWindow *)window andGesture:(UITapGestureRecognizer *)gesture andRootViewController:(RZDebugMenuDummyViewController *)root
//{
//    self = [super init];
//    if (self) {
//        _sharedManager = [RZDebugMenuSharedManager sharedTopLevel];
//        _sharedManager.topWindow = window;
//        _sharedManager.tripleTap = gesture;
//        _sharedManager.clearViewController = root;
//    }
//    return self;
//}

+ (void)enable
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:kRZSettingsFileTitle ofType:kRZSettingsFileExtension];
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    RZDebugMenuSettingsInterface *debugSettingsInterface = [[RZDebugMenuSettingsInterface alloc] initWithDictionary:plistData];
    RZDebugMenuModalViewController *modalViewController = [[RZDebugMenuModalViewController alloc] initWithInterface:debugSettingsInterface];
    RZDebugMenuDummyViewController *dummyViewController = [[RZDebugMenuDummyViewController alloc] init];
    UINavigationController *dummyNavigationController = [[UINavigationController alloc] initWithRootViewController:dummyViewController];
    dummyViewController.view.backgroundColor = [UIColor clearColor];
    
    UIApplication *application = [UIApplication sharedApplication];
    UIWindow *applicationWindow = application.keyWindow;
    
    UITapGestureRecognizer *tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:dummyViewController action:@selector(showViewController)];
    
    tripleTap.numberOfTapsRequired = 3;
    tripleTap.numberOfTouchesRequired = 1;
    [applicationWindow addGestureRecognizer:tripleTap];
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    
    RZDebugMenuWindow *window = [[RZDebugMenuWindow alloc] initWithFrame:mainScreen.bounds];
    window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    window.rootViewController = dummyNavigationController;
    window.backgroundColor = [UIColor redColor];
    window.windowLevel = UIWindowLevelAlert;
    [applicationWindow addSubview:window];
    
}

@end
