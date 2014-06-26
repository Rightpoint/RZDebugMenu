//
//  RZDebugMenuVersionItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//
// NOTE: This class is READONLY and can not be altered via any interfaces

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuVersionItem : RZDebugMenuSettingsItem

@property (strong, nonatomic, readonly) NSString *versionNumber;

- (id)initWithTitle:(NSString *)title andVersionNumber:(NSString *)version;

@end
