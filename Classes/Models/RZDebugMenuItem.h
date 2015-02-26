//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuItem : NSObject

@property (copy, nonatomic, readonly) NSString *title;

- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

@end
