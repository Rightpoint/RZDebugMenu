//
//  RZDebugMenuSettings_Private.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/24/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettings.h"

@interface RZDebugMenuSettings ()

+ (void)initializeWithKeys:(NSArray *)keys defaultValues:(NSDictionary *)defaultvalues;

- (void)postChangeNotificationSettingsName:(NSString *)settingName previousValue:(id)oldValue newValue:(id)newValue;

@end
