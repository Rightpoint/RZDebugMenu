//
//  RZDebugMenuMultiValueItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuMultiValueItem : RZDebugMenuSettingsItem

@property (strong, nonatomic, readonly) NSArray *selectionItems;

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title selectionItems:(NSArray *)selectionItems;

@end
