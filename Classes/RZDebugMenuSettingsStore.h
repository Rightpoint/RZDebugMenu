//
//  RZDebugMenuSettingsStore.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@protocol RZDebugMenuSettingsStore <NSObject>

- (instancetype)initWithKeys:(NSArray *)keys defaultValues:(NSDictionary *)defaultValues;

/**
 *  Reset all debug settings to their default values.
 */
- (void)reset;

/**
 *  Default settings value for key.
 *
 *  @param key Key to get the default value for.
 *
 *  @return Default settings value for this key.
 */
- (id)defaultValueForKey:(id)key;

@property (copy, nonatomic, readonly) NSArray *keys;

// Keyed Access methods.

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

// These are all standard KVO methods. Standard KVO is the best way to interaction with this class.

- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end


@interface RZDebugMenuSettingsStore : NSObject <RZDebugMenuSettingsStore>

@end