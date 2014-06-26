//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsItem : NSObject

@property (strong, nonatomic) NSString *tableViewCellTitle;
@property (strong, nonatomic, readonly) NSString *settingsKey;
@property (strong, nonatomic, readwrite) id settingsValue;

- (id)initWithValue:(id)value forKey:(NSString *)key;

@end
