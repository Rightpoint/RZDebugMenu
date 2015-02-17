//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuItem : NSObject

@property (strong, nonatomic, readonly) NSString *title;

- (id)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

@end
