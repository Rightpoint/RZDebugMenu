//
//  RZDebugMenuSettingsObserverManager.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuSettingsObserverManager : NSObject

+ (instancetype)sharedInstance;

- (void)addObserver:(id)observer selector:(SEL)selector forKey:(NSString *)key updateImmediately:(BOOL)update;
- (void)removeObserver:(id)observer forKey:(NSString *)key;

@end
