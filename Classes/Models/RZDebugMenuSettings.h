//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsStore.h"

@interface RZDebugMenuSettings : NSObject

+ (void)setValue:(id)value forDebugSettingsKey:(NSString *)key;
+ (id)valueForDebugSettingsKey:(NSString *)key;

+ (void)setSharedDebugSettingsStore:(id <RZDebugMenuSettingsStore>)settingsStore;
+ (id <RZDebugMenuSettingsStore>)sharedDebugSettingsStore;

@end
