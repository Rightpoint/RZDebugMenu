//
//  RZDebugMenuVersionItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//
// NOTE: This class is READONLY and can not be altered via any interfaces

#import "RZDebugMenuItem.h"

@interface RZDebugMenuVersionItem : RZDebugMenuItem

@property (copy, nonatomic, readonly) NSString *versionString;

/**
 *  Use this method to automatically guess the version string from Info.plist.
 *
 *  @return Newly initialized instance.
 */
- (instancetype)init;

/**
 *  Use this method to manually specify a version string.
 *
 *  @param version Version string.
 *
 *  @return Newly initialized instance.
 */
- (instancetype)initWithVersionString:(NSString *)version NS_DESIGNATED_INITIALIZER;

@end
