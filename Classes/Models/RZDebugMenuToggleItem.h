//
//  RZDebugMenuToggleItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuToggleItem : RZDebugMenuSettingsItem

@property (strong, nonatomic, readonly) NSNumber *toggleCellDefaultValue;
@property (strong, nonatomic, readonly) NSString *userDefaultsKey;

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andKey:(NSString *)key;

@end
