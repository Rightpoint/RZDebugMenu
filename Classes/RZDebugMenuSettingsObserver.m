//
//  RZDebugMenuSettingsObserver.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsObserver.h"

@interface RZDebugMenuSettingsObserver ()

@property (strong, nonatomic, readwrite) NSMutableSet *observers;

@end

@implementation RZDebugMenuSettingsObserver

- (id)init
{
    self = [super init];
    if ( self ) {
        _observers = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)addObserver:(id)observer
{
    
}

- (void)removeObserver:(id)observer
{
    
}

- (void)notifyObservers:(NSInvocation *)invocation
{
    
}

@end
