//
//  RZDebugMenuSettingsObserverManager.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsObserverManager.h"
#import "RZDebugMenuObserver.h"

@interface RZDebugMenuSettingsObserverManager ()

@property (strong, nonatomic, readwrite) NSMapTable *observerKeyMap;

@end

@implementation RZDebugMenuSettingsObserverManager

- (id)init
{
    self = [super init];
    if ( self ) {
        _observerKeyMap = [[NSMapTable alloc] init];
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
{
    
}

- (void)removeObserver:(id)observer
{
    
}

- (void)notifyObservers:(NSInvocation *)invocation
{
    
}

@end
