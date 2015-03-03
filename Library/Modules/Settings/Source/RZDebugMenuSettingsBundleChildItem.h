//
//  RZDebugChildPaneMenuItem.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuSettingsBundleChildItem : RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSString *plistName;

@end
