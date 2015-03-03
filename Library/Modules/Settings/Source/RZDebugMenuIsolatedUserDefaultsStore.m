//
//  RZDebugMenuIsolatedUserDefaultsStore.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/24/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuIsolatedUserDefaultsStore.h"

#import "RZDebugMenuSettings_Private.h"

static NSString *const kRZIsolatedUserDefaultsDictionaryKey = @"debugSettings";

@interface RZDebugMenuIsolatedUserDefaultsStore ()

@end

@implementation RZDebugMenuIsolatedUserDefaultsStore

- (void)setValue:(id)value forKey:(NSString *)key
{
    id previousValue = [self valueForKey:key];

    id defaultValue = [self defaultValueForKey:key];
    if ( value && [previousValue isEqual:value] ) {
        // Nothing to do here. Don't even send change notifications.
        return;
    }

    [self willChangeValueForKey:key];

    NSDictionary *debugSettingsDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRZIsolatedUserDefaultsDictionaryKey];

    NSMutableDictionary *mutableDebugSettingsDictionary = debugSettingsDictionary ? [debugSettingsDictionary mutableCopy] : [NSMutableDictionary dictionary];

    // For a default value, simply remove the key and it will fall through to our part.
    if ( value && [value isEqual:defaultValue] == NO ) {
        mutableDebugSettingsDictionary[key] = value;
    }
    else {
        [mutableDebugSettingsDictionary removeObjectForKey:key];
    }

    debugSettingsDictionary = [mutableDebugSettingsDictionary copy];

    [[NSUserDefaults standardUserDefaults] setObject:debugSettingsDictionary forKey:kRZIsolatedUserDefaultsDictionaryKey];

    [self didChangeValueForKey:key];

    [[RZDebugMenuSettings sharedSettings] postChangeNotificationSettingsName:key previousValue:previousValue newValue:value];
}

- (id)innerValueForKey:(NSString *)key
{
    NSDictionary *debugSettingsDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRZIsolatedUserDefaultsDictionaryKey];

    id objectToReturn = [debugSettingsDictionary objectForKey:key];
    return objectToReturn;
}

- (id)valueForKey:(NSString *)key
{
    id objectToReturn = [self innerValueForKey:key];
    if ( objectToReturn == nil ) {
        objectToReturn = [super valueForKey:key];
    }

    return objectToReturn;
}

- (void)reset
{
    NSDictionary *debugSettingsDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kRZIsolatedUserDefaultsDictionaryKey];

    __block NSMutableDictionary *previousValues = nil;

    NSArray *keysBeingReset = [[debugSettingsDictionary keyEnumerator] allObjects];
    [keysBeingReset enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {

        id previousValue = [self innerValueForKey:key];
        if ( previousValue ) {
            if ( previousValues == nil ) {
                previousValues = [NSMutableDictionary dictionary];
            }

            previousValues[key] = previousValue;
        }

        [self willChangeValueForKey:key];
    }];

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRZIsolatedUserDefaultsDictionaryKey];

    [[[keysBeingReset reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        [self didChangeValueForKey:key];

        id defaultValue = [self defaultValueForKey:key];
        id previousValue = previousValues[key];

        if ( previousValue ) {
            [[RZDebugMenuSettings sharedSettings] postChangeNotificationSettingsName:key previousValue:previousValue newValue:defaultValue];
        }
    }];
}

@end
