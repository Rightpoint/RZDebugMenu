//
//  RZSettingsManager.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSettingsManager.h"

static const NSString *kRZEnvironmentsPlistKey = @"Environments";
static const NSString *kRZTogglePlistKey = @"Reset";


@implementation RZSettingsManager

+ (id)settingsManager
{
    static RZSettingsManager* settingsManager;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        settingsManager = [[self alloc] init];
    });
    return settingsManager;
}

- (id)init
{
    if ( self == [super init] ) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"plist"];
        _settingsPlistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

+ (void)toggleReset
{
    NSNumber *resetIsOn = [[RZSettingsManager settingsManager] settingsPlistDictionary][kRZTogglePlistKey];
    
    if ( resetIsOn.boolValue ) {
        [[RZSettingsManager settingsManager] settingsPlistDictionary][kRZTogglePlistKey] = @NO;
    }
    else {
        [[RZSettingsManager settingsManager] settingsPlistDictionary][kRZTogglePlistKey] = @YES;
    }
}

+ (void)switchEnvironments
{
    
}

@end
