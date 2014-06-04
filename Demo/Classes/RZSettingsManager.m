//
//  RZSettingsManager.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSettingsManager.h"

@implementation RZSettingsManager

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

}

+ (void)switchEnvironments
{
    
}

@end
