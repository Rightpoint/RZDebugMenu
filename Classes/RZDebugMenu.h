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
 *  Observer notification name constant. Notification with this name sent on a change in the Debug Menu
 */
OBJC_EXTERN NSString* const kRZDebugMenuSettingChangedNotification;

@interface RZDebugMenu : NSObject
/** @name RZDebugMenu Interface */

/**
*  Enables the debug menu with a specified settings plist
*
*  @param fileName Name of the plist which have the settings definitions as NSString
*  @warning Can not call 'init' on this class, otherwise app will throw exception
*/
+ (void)enableWithSettingsPlist:(NSString *)fileName;

/**
 *  Returns the setting value for a specified setting key defined in the plist
 *
 *  @param key Key as defined in the plist under the 'Key' field
 *
 *  @return An object that is the value of the indexed setting
 */
+ (id)debugSettingForKey:(NSString *)key;

/**
 *  Sets an object to observe changes for a particular setting
 *
 *  @param observer  Object to observe changes
 *  @param aSelector A selector to perform when a setting that an object is observing changes
 *  @param key       The key whose value a change will be observed for
 *
 *  @note If the selector accepts an id parameter, it will be passed the new value for the key that changed
 */
+ (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;

/**
 *  Removes an object currently observing for a settings change
 *
 *  @param observer Object you wish to remove from the observer pool
 *  @param key      The key the observer was observing a change on
 */
+ (void)removeObserver:(id)observer forKey:(NSString *)key;

@end
