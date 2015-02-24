//
//  RZDebugMenuSettingsInterface.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettings.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuSettingsStore.h"
#import "RZDebugMenuSettings_Private.h"
#import "RZDebugMenuIsolatedUserDefaultsStore.h"

NSString *const kRZDebugMenuSettingChangedNotificationSettingKey = @"setting";
NSString *const kRZDebugMenuSettingChangedNotificationSettingPreviousValueKey = @"previousValue";
NSString *const kRZDebugMenuSettingChangedNotificationSettingNewValueKey = @"newValue";

@interface RZDebugMenuSettings ()

@property (copy, nonatomic, readwrite) NSArray *keys;
@property (copy, nonatomic, readwrite) NSDictionary *defaultValues;

@property (strong, nonatomic, readwrite) Class debugSettingsStoreClass;

@property (strong, nonatomic, readwrite) id <RZDebugMenuSettingsStore> settingsStore;

@end

@implementation RZDebugMenuSettings

@synthesize debugSettingsStoreClass = _debugSettingsStoreClass;

static RZDebugMenuSettings *s_sharedSettings;

+ (RZDebugMenuSettings *)sharedSettings
{
    NSAssert(s_sharedSettings != nil, @"Settings access before initialization!");
    return s_sharedSettings;
}

+ (void)initializeWithKeys:(NSArray *)keys defaultValues:(NSDictionary *)defaultvalues
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedSettings = [[RZDebugMenuSettings alloc] initWithKeys:keys defaultValues:defaultvalues];
    });
}

- (instancetype)initWithKeys:(NSArray *)keys defaultValues:(NSDictionary *)defaultValues
{
    self = [super init];
    if ( self ) {
        self.keys = keys;
        self.defaultValues = defaultValues;
    }

    return self;
}

- (id <RZDebugMenuSettingsStore>)settingsStore
{
    if ( _settingsStore == nil ) {
        Class DebugSettingsStoreClass = _debugSettingsStoreClass;

        NSAssert(DebugSettingsStoreClass == Nil || [DebugSettingsStoreClass conformsToProtocol:@protocol(RZDebugMenuSettingsStore)], @"");

        if ( DebugSettingsStoreClass == Nil  ) {
            DebugSettingsStoreClass = [RZDebugMenuIsolatedUserDefaultsStore class];
        }

        _settingsStore = [[DebugSettingsStoreClass alloc] initWithKeys:self.keys defaultValues:self.defaultValues];
    }

    return _settingsStore;
}

- (void)reset
{
    [self.settingsStore reset];
}

// Keyed access pass-through.

- (id)objectForKeyedSubscript:(id <NSCopying>)key
{
    return [self.settingsStore objectForKeyedSubscript:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key
{
    [self.settingsStore setObject:obj forKeyedSubscript:key];
}

// KVO pass-through.

- (id)valueForKey:(NSString *)key
{
    return [self.settingsStore valueForKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [self.settingsStore setValue:value forKey:key];
}

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [self.settingsStore addObserver:observer forKeyPath:keyPath options:options context:context];
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    [self.settingsStore removeObserver:observer forKeyPath:keyPath context:context];
}

- (void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    [self.settingsStore removeObserver:observer forKeyPath:keyPath];
}

// Store Access

- (void)setDebugSettingsStoreClass:(Class)DebugSettingsStoreClass
{
    NSAssert(self.settingsStore == nil, @"The settings store class can not be set after initialization of the settings store.");
    _debugSettingsStoreClass = DebugSettingsStoreClass;
}

// Notifications

- (void)postChangeNotificationSettingsName:(NSString *)settingName previousValue:(id)previousValue newValue:(id)newValue
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    if ( settingName ) {
        userInfo[kRZDebugMenuSettingChangedNotificationSettingKey] = settingName;
    }

    if ( previousValue ) {
        userInfo[kRZDebugMenuSettingChangedNotificationSettingPreviousValueKey] = previousValue;
    }

    if ( newValue ) {
        userInfo[kRZDebugMenuSettingChangedNotificationSettingNewValueKey] = newValue;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:kRZDebugMenuSettingChangedNotification object:self userInfo:[userInfo copy]];
}

@end
