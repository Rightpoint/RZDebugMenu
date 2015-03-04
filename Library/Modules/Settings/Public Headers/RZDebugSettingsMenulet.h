//
//  RZDebugSettingsMenulet.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/3/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenulet.h"

@interface RZDebugSettingsMenulet : NSObject <RZDebugMenulet>

- (instancetype)initWithSettingsPlistName:(NSString *)plistName;

@property (copy, nonatomic, readonly) NSArray *menuItems;

@end
