//
//  RZDebugMenuSettingsObserver.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsObserver : NSObject

- (void)addObserver:(NSObject *)observer;
- (void)removeObserver:(NSObject *)observer;
- (void)notifyObservers:(NSInvocation *)invocation;

@end
