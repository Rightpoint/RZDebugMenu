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
@property(nonatomic, readwrite, strong) NSArray *selectionTitles;
@property(nonatomic, readwrite, strong) NSArray *selectionValues;

@end

@implementation RZDebugMenuMultiValueItem

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value andOptions:(NSArray *)options withValues:(NSArray *)optionValues
{
    self = [super init];
    if ( self ) {
        self.tableViewCellTitle = title;
        _disclosureTableViewCellDefaultValue = value;
        _selectionTitles = options;
        _selectionValues = optionValues;
    }
    return self;
}

@end
