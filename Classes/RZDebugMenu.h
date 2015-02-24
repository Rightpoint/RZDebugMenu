//
//  RZDebugMenu.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuClearViewController.h"

/**
 *  Observer notification name constant. Notification with this name sent on a change in the Debug Menu. The userInfo on the Notification sent contains the setting's key:value pair that was changed.
 */
OBJC_EXTERN NSString* const kRZDebugMenuSettingChangedNotification;

/**
 *  RZDebug Menu Class
 *
 *  @warning Can not call 'init' on this class, otherwise app will throw exception
 */
@interface RZDebugMenu : NSObject
/** @name RZDebugMenu Interface */

/**
 *  Enables the debug menu with a specified settings plist
 *
 *  @param fileName Name of the plist which defines the debug settings to be used. The plist should conform to the standard Settings Bundle plist format.
 */
+ (void)enableMenuWithSettingsPlistName:(NSString *)plistName;

/**
 *  Access the shared debug menu.
 *
 *  @return If yopu have called enableMenuWithSettingsPlistName:, this will return the shared debug debug.
 */
+ (instancetype)sharedDebugMenu;

/**
 *  Configure automatic show / hide of the debug menu button with a 5-tap gesture on the selected window.

 *  @param window   The window to set up for automatic show / hide of the debug menu button.
 */
- (void)configureAutomaticShowHideOnWindow:(UIWindow *)window;

@property (assign, nonatomic) BOOL enabled;
@property (assign, nonatomic, readwrite) BOOL showDebugMenuButton;

@end
