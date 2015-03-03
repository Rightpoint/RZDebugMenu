//
//  RZDebugMenuSettingsParser.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@interface RZDebugMenuSettingsParser : NSObject

+ (NSArray *)settingsMenuItemsFromSettingsDictionary:(NSDictionary *)settingsDictionary
                                       returningKeys:(NSArray **)outKeys
                                       defaultValues:(NSDictionary **)outDefaultValues
                                               error:(NSError * __autoreleasing *)outError;

+ (NSArray *)settingsMenuItemsFromPlistName:(NSString *)plistName
                              returningKeys:(NSArray **)outKeys
                              defaultValues:(NSDictionary **)outDefaultValues
                                      error:(NSError * __autoreleasing *)outError;

@end
