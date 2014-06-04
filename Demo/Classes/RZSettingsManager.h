//
//  RZSettingsManager.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZSettingsManager : NSObject

@property (nonatomic, strong) NSDictionary *settingsPlistDictionary;

+ (id)settingsManager;
+ (void)toggleReset;
+ (void)switchEnvironments;

@end
