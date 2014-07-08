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
 Observer notification name constant. Notification with this name
 sent on a change in the Debug Menu
 */
OBJC_EXTERN NSString* const kRZDebugMenuSettingChangedNotification;

@interface RZDebugMenu : NSObject

+ (void)enableWithSettingsPlist:(NSString *)fileName;
+ (id)debugSettingForKey:(NSString *)key;
+ (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
+ (void)removeObserver:(id)observer forKey:(NSString *)key;

@end
