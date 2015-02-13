//
//  RZDebugMenuSettingsObserverManager.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsObserverManager.h"
#import "RZDebugMenuObserver.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuSettingsObserverManager ()

@property (strong, nonatomic, readwrite) NSMutableDictionary *observersByKey;

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
        _observersByKey = [[NSMutableDictionary alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(notifyObserversForNotification:)
                                                     name:kRZDebugMenuSettingChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)addObserver:(id)observer selector:(SEL)selector forKey:(NSString *)key updateImmediately:(BOOL)update
{
    RZDebugMenuObserver *newObserver = [[RZDebugMenuObserver alloc] initWithObserver:observer selector:selector];
    
    NSMutableSet *observers = [self.observersByKey objectForKey:key];
    if ( observers == nil ) {
        observers = [[NSMutableSet alloc] init];
        [observers addObject:newObserver];
        [self.observersByKey setObject:observers forKey:key];
    }
    else {
        [observers addObject:newObserver];
    }
    
    if ( update ) {
        id defaultsValue = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:key];
        [self performSelector:selector onObserver:observer withValue:defaultsValue];
    }
}

- (void)removeObserver:(id)observer forKey:(NSString *)key
{
    NSMutableSet *observers = [self.observersByKey objectForKey:key];
    [observers removeObject:observer];
}

- (void)notifyObserversWithValue:(id)value forKey:(NSString *)key
{
    NSSet *observers = [self.observersByKey objectForKey:key];

    for (RZDebugMenuObserver *observer in observers) {
        id target = observer.target;
        SEL action = observer.selector;
        [self performSelector:action onObserver:target withValue:value];
    }
}

- (void)notifyObserversForNotification:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];

    NSString *key = [userInfo allKeys][0];
    id value = [userInfo objectForKey:key];

    [self notifyObserversWithValue:value forKey:key];
}

- (void)performSelector:(SEL)action onObserver:(id)observer withValue:(id)value
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [observer performSelector:action withObject:value];
#pragma clang diagnostic pop
}

@end
