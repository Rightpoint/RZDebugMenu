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

- (void)setKeysWithArray:(NSArray *)keys
{
    for (NSString *key in keys) {
        NSMutableSet *observers = [[NSMutableSet alloc] init];
        [self.observerKeyMap setObject:observers forKey:key];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyObserversForNotification:)
                                                     name:key
                                                   object:nil];
    }
}

- (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
{
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    RZDebugMenuObserver *newObserver = [[RZDebugMenuObserver alloc] initWithObserver:observer selector:aSelector];
    
    if ( !observers ) {
        NSLog(@"Warning! Not using a predefined key from the plist");
    }
    else {
        [observers addObject:newObserver];
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

- (void)notifyObserversForNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *key = [userInfo allKeys][0];
    [self notifyObserversForKey:key];
}

@end
