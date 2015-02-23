//
//  RZDebugMenuUserDefaultsStore.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuUserDefaultsStore.h"

@interface RZDebugMenuUserDefaultsStore ()

@property (copy, nonatomic, readwrite) NSArray *keys;

@end

@implementation RZDebugMenuUserDefaultsStore

- (instancetype)initWithKeys:(NSArray *)keys
{
    self = [super init];
    if ( self ) {
        self.keys = keys;
    }

    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [self willChangeValueForKey:key];
    
    if ( value ) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }

    [self didChangeValueForKey:key];
}

- (id)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (void)reset
{
    for ( NSString *key in self.keys ) {
        [self setValue:nil forKey:key];
    }
}

@end
