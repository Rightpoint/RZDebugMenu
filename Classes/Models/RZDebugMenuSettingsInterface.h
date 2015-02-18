//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuSettingsInterface : NSObject

+ (void)setValue:(id)value forDebugSettingsKey:(NSString *)key;
+ (id)valueForDebugSettingsKey:(NSString *)key;
+ (NSString *)generateSettingsKey:(NSString *)identifier;

@end
