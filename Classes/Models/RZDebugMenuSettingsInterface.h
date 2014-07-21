//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsInterface : NSObject

+ (void)setValue:(id)value forDebugSettingsKey:(NSString *)key;
+ (id)valueForDebugSettingsKey:(NSString *)key;
+ (void)resetSettings;
+ (NSString *)generateSettingsKey:(NSString *)identifier;

@end
