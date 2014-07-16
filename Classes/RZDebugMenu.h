//
//  RZDebugMenu.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
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
+ (void)enableWithSettingsPlist:(NSString *)fileName;

/**
 *  Returns the setting value for a specified setting key defined in the plist
 *
 *  @param key Key as defined in the plist under the 'Key' field
 *
 *  @return An object that is the value of the indexed setting, or nil if the key is not valid
 */
+ (id)debugSettingForKey:(NSString *)key;

/**
 *  Sets an object to observe changes for a particular setting
 *
 *  @param observer  Object to observe changes
 *  @param aSelector A selector to perform when a setting that an object is observing changes
 *  @param key       The key whose value a change will be observed for
 *
 *  @note If the selector accepts a parameter, it will be passed the new value for the key that changed
 */
+ (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key updateImmediately:(BOOL)update;

/**
 *  Removes an object currently observing for a settings change
 *
 *  @param observer Object to remove as an observer
 *  @param key      The key the observer was observing a change on
 */
+ (void)removeObserver:(id)observer forKey:(NSString *)key;

@end
