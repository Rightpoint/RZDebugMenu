//
//  RZDebugMenuSettingsObserver.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsObserver : NSObject

- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;
- (void)notifyObservers:(NSInvocation *)invocation;

@end
