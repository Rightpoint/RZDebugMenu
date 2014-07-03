//
//  RZDebugMenuSettingsObserverManager.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsObserverManager.h"
#import "RZDebugMenu.h"
#import "RZDebugMenuObserver.h"

@interface RZDebugMenuSettingsObserverManager ()

@property (strong, nonatomic, readwrite) NSMutableDictionary *observerKeyMap;

@end

@implementation RZDebugMenuSettingsObserverManager

+ (instancetype)sharedInstance
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
        _observerKeyMap = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyObserversForNotification:)
                                                     name:kRZDebugMenuSettingChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)aSelector forKey:(NSString *)key;
{
    RZDebugMenuObserver *newObserver = [[RZDebugMenuObserver alloc] initWithObserver:observer selector:aSelector];
    
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    if ( observers == NULL ) {
        observers = [[NSMutableSet alloc] init];
        [observers addObject:newObserver];
        [self.observerKeyMap setObject:observers forKey:key];
    }
    else {
        [observers addObject:newObserver];
    }
}

- (void)removeObserver:(id)observer forKey:(NSString *)key
{
    NSMutableSet *observers = [self.observerKeyMap objectForKey:key];
    [observers removeObject:observer];
}

- (void)notifyObserversWithValue:(id)value forKey:(NSString *)key
{
    
    NSSet *observers = [self.observerKeyMap objectForKey:key];
    for (RZDebugMenuObserver *observer in observers) {
        id target = observer.target;
        SEL action = observer.aSelector;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        NSLog(@"%@", value);
        [target performSelector:action withObject:value];
#pragma clang diagnostic pop
    }
}

- (void)notifyObserversForNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSString *key = [userInfo allKeys][0];
    id value = [userInfo objectForKey:key];
    [self notifyObserversWithValue:value forKey:key];
}

@end
