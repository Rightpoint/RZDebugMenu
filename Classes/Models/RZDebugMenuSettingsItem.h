//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuSettingsItem : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic) id value;

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title NS_DESIGNATED_INITIALIZER;

@end
