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

+ (instancetype)standardObserverManager
{
    static RZDebugMenuSettingsObserverManager *observerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        observerManager = [[RZDebugMenuSettingsObserverManager alloc] init_private];
    });
    return observerManager;
}

- (id)init_private
{
    self = [super init];
    if ( self ) {
        _observerKeyMap = [[NSMapTable alloc] init];
    }
    return self;
}

- (void)listenForKeysWithArray:(NSArray *)keys
{
    for (NSString *key in keys) {
        NSMutableSet *observers = [[NSMutableSet alloc] init];
        [self.observerKeyMap setObject:observers forKey:key];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyObserversForKey:)
                                                     name:key
                                                   object:nil];
    }
}

- (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
{
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    RZDebugMenuObserver *newObserver = [[RZDebugMenuObserver alloc] initWithObserver:observer selector:aSelector];
    
    if ( !observers ) {
        observers = [[NSMutableSet alloc] init];
        [observers addObject:newObserver];
        [self.observerKeyMap setObject:observers forKey:key];
    }
    else {
        [observers addObject:newObserver];
    }
    
    for (id object in observers) {
        NSLog(@"%@", object);
    }
}

- (void)removeObserver:(id)observer forKey:(NSString *)key
{
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    if ( !observers ) {
        [observers removeObject:observer];
    }
}

- (void)notifyObserversForKey:(NSString *)key
{
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    for (RZDebugMenuObserver *RZObserver in observers) {
        id target = RZObserver.observer;
        SEL action = RZObserver.aSelector;
        [target performSelector:action];
    }
}

@end
