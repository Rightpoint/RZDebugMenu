//
//  RZDebugMenuObserver.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/1/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuObserver.h"

@implementation RZDebugMenuObserver

- (id)initWithObserver:(id)observer selector:(SEL)aSelector
{
    self = [super init];
    if ( self ) {
        _target = observer;
        _aSelector = aSelector;
    }
    return self;
}

@end
