//
//  RZDebugMenuSettingsObserverManager.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsObserverManager : NSObject

+ (instancetype)sharedInstance;

- (void)setKeysWithArray:(NSArray *)keys;
- (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
- (void)removeObserver:(id)observer forKey:(NSString *)key;
- (void)notifyObserversForKey:(NSString *)key;

@end
