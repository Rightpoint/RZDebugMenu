//
//  RZDebugMenuMultiValueItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiValueItem.h"

@interface RZDebugMenuMultiValueItem ()

@property(nonatomic, readwrite, strong) NSNumber *disclosureTableViewCellDefaultValue;
@property(nonatomic, readwrite, strong) NSArray *selectionTableViewCellMetaData;

@end

@implementation RZDebugMenuMultiValueItem

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andSelectionItems:(NSArray *)selectionItems
{
    self = [super init];
    if ( self ) {
        self.tableViewCellTitle = title;
        _disclosureTableViewCellDefaultValue = value;
        _selectionTableViewCellMetaData = selectionItems;
    }
    return self;
}

@end
