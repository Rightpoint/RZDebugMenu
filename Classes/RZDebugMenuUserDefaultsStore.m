//
//  RZDebugMenuUserDefaultsStore.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuUserDefaultsStore.h"

@interface RZDebugMenuUserDefaultsStore ()

@end

@implementation RZDebugMenuUserDefaultsStore

- (void)setValue:(id)value forKey:(NSString *)key
{
    id defaultValue = [self defaultValueForKey:key];
    if ( value && [value isEqual:defaultValue] ) {
        // Nothing to do here. Don't even send change notifications.
        return;
    }

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
    id objectToReturn = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if ( objectToReturn == nil ) {
        objectToReturn = [super valueForKey:key];
    }

    return objectToReturn;
}

- (void)reset
{
    for ( NSString *key in self.keys ) {
        if ( [[NSUserDefaults standardUserDefaults] objectForKey:key] != nil ) {
            [self willChangeValueForKey:key];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            [self didChangeValueForKey:key];
        }
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying, NSObject>)key
{
    NSAssert([key isKindOfClass:[NSString class]], @"");

    [self setValue:obj forKey:(NSString *)key];
}

- (id)objectForKeyedSubscript:(id <NSCopying, NSObject>)key
{
    NSAssert([key isKindOfClass:[NSString class]], @"");

    return [self valueForKey:(NSString *)key];
}

@end
