//
//  RZDebugMenuSettingsInterface.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsInterface.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuSettingsItem.h"

static NSString * const kRZUserSettingsDebugPrefix = @"DEBUG_";

@implementation RZDebugMenuSettingsInterface

#pragma mark - User default getter method

+ (id)valueForDebugSettingsKey:(NSString *)key
{
    NSString *settingKey = [self generateSettingsKey:key];
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:settingKey];
}

#pragma mark - User default setter method

+ (void)setValue:(id)value forDebugSettingsKey:(NSString *)key
{
    if ( key != nil && value != nil ) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userDefaultsKey = [self generateSettingsKey:key];
        
        if ( [userDefaults objectForKey:userDefaultsKey] != value ) {
            
            NSDictionary *userInfo;
            
            if ( value == nil ) {
                userInfo = @{key: [NSNull null]};
            }
            else {
                userInfo = @{key: value};
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kRZDebugMenuSettingChangedNotification
                                                                object:nil
                                                              userInfo:userInfo];
            
            [userDefaults setObject:value forKey:userDefaultsKey];
        }
    }
}

#pragma mark - reset setting method

+ (void)resetDefaultsForSettings:(NSDictionary *)settingsItems
{
    // settingsItems is dictionary registered with user defaults. Still holds original default values
    NSArray *sections = [settingsItems allKeys];
    for ( NSString *section in sections ) {
        NSArray *sectionSettings = [settingsItems objectForKey:section];
        
        for ( RZDebugMenuSettingsItem *settingItem in sectionSettings ) {
            [self setValue:settingItem.settingsValue forDebugSettingsKey:settingItem.settingsKey];
        }
    }
}

#pragma mark - Preprocessing methods

+ (NSString *)generateSettingsKey:(NSString *)identifier
{
    return [NSString stringWithFormat:@"%@%@", kRZUserSettingsDebugPrefix, identifier];
}

@end
