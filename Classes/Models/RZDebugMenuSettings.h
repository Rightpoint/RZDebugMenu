//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsStore.h"

@interface RZDebugMenuSettings : NSObject

+ (RZDebugMenuSettings *)sharedSettings;

// Keyed access methods.
// You can access and settings via [RZDebugMenuSettings sharedSettings][@"my_setting_value"]

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

// These are all standard KVO methods. Standard KVO is the best way to interaction with this class.

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/**
 *  Reset all debug settings to their default values.
 */
- (void)reset;

/**
 *  Set the class of the store used to persist the debug settigs. By default, this will by an isolated user defaults store.
 *
 *  @param DebugSettingsStoreClass A class with instances that conform to the RZDebugMenuSettingsStore protocol.
 */
- (void)setDebugSettingsStoreClass:(Class)DebugSettingsStoreClass;
- (Class)debugSettingsStoreClass;

@end
