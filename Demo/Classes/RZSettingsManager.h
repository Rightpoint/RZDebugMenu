//
//  RZSettingsManager.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZSettingsManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *settingsPlistDictionary;

+ (id)settingsManager;
+ (BOOL)getToggleValue;
+ (void)toggleReset;
+ (void)switchEnvironments;

@end
