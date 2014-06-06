//
//  RZDebugMenuMultiValueItem.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiValueItem.h"

@implementation RZDebugMenuMultiValueItem

- (id)initWithTitle:(NSString *)title defaultValue:(NSString *)value andOptions:(NSArray *)options withValues:(NSArray *)optionValues
{
    self = [super init];
    if ( self ) {
        _disclosureTableViewCellTitle = title;
        _disclosureTableViewCellDefaultValue = value;
        _selectionTitles = options;
        _selectionValues = optionValues;
    }
    return self;
}

@end
