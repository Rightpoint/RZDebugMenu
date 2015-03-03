//
//  RZDebugMenuLoadedChildPaneItem.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsBundleChildItem.h"

@interface RZDebugMenuLoadedSettingsBundleChildItem : RZDebugMenuSettingsBundleChildItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName settingsMenuItems:(NSArray *)settingsMenuItems NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSArray *settingsMenuItems;

@end
