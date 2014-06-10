//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsItem : NSObject

@property(nonatomic, strong) NSString *tableViewCellTitle;

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andOptions:(NSArray *)options withValues:(NSArray *)optionValues;
- (id)initWithTitle:(NSString *)title andValue:(BOOL)value;
- (id)initWithTitle:(NSString *)title andVersionNumber:(NSString *)version;

@end
