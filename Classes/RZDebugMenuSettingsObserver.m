//
//  RZDebugMenuSettingsObserver.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/26/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsObserver.h"

@interface RZDebugMenuSettingsObserver ()

@property (weak, nonatomic, readwrite) NSMutableSet *observers;

@end

@implementation RZDebugMenuSettingsObserver

- (id)init
{
    self = [super init];
    if ( self ) {
        // do stuff
    }
    return self;
}

- (void)addObserver:(NSObject *)observer
{
    
}

- (void)removeObserver:(NSObject *)observer
{
    
}

- (void)notifyObservers:(NSInvocation *)invocation
{
    
}

@end
