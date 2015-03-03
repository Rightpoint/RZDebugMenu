//
//  RZDebugMenuUserDefaultsStore.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuUserDefaultsStore.h"

#import "RZDebugMenuSettings_Private.h"

@interface RZDebugMenuUserDefaultsStore ()

@end

@implementation RZDebugMenuUserDefaultsStore

- (void)setValue:(id)value forKey:(NSString *)key
{
    id previousValue = [self valueForKey:key];

    id defaultValue = [self defaultValueForKey:key];
    if ( value && [previousValue isEqual:value] ) {
        // Nothing to do here. Don't even send change notifications.
        return;
    }

    [self willChangeValueForKey:key];

    // For a default value, simply remove the key and it will fall through to our part.
    if ( value && [value isEqual:defaultValue] == NO ) {
        [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }

    [self didChangeValueForKey:key];

    [[RZDebugMenuSettings sharedSettings] postChangeNotificationSettingsName:key previousValue:previousValue newValue:value];
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
        id previousValue = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        if ( previousValue != nil ) {
            [self willChangeValueForKey:key];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            [self didChangeValueForKey:key];

            id defaultValue = [self defaultValueForKey:key];
            [[RZDebugMenuSettings sharedSettings] postChangeNotificationSettingsName:key previousValue:previousValue newValue:defaultValue];
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
