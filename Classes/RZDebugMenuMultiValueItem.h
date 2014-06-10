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

@property(nonatomic, readonly, strong) NSNumber *disclosureTableViewCellDefaultValue;
//@property(nonatomic, readonly, strong) NSArray *selectionTitles;
//@property(nonatomic, readonly, strong) NSArray *selectionValues;
@property(nonatomic, readonly, strong) NSArray *selectionTableViewCellMetaData;

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andSelectionItems:(NSArray *)selectionItems;

@end
