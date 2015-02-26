//
//  RZDebugMenuMultiValueItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingItem.h"

@interface RZDebugMenuMultiValueItem : RZDebugMenuSettingItem

@property (strong, nonatomic, readonly) NSArray *selectionItems;

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title selectionItems:(NSArray *)selectionItems NS_DESIGNATED_INITIALIZER;

@end
