//
//  RZSettingsManager.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSettingsManager.h"

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
        _settingsPlistDictionary = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

+ (void)toggleReset
{
    
}

+ (void)switchEnvironments
{
    
}

@end