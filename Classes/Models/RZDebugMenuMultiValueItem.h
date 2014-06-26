//
//  RZDebugMenuMultiValueItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuMultiValueItem : RZDebugMenuSettingsItem

@property (strong, nonatomic, readonly) NSArray *selectionItems;

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title andSelectionItems:(NSArray *)selectionItems;

@end
