//
//  RZDebugMenuSettingsStore.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@protocol RZDebugMenuSettingsStore <NSObject>

- (instancetype)initWithKeys:(NSArray *)keys;

- (void)reset;

// These are all standard KVO methods. Stadnard KVO is the best way to interaction with this class.
- (id)valueForKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;
- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

@end
