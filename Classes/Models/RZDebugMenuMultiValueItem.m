//
//  RZDebugMenuMultiValueItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiValueItem.h"

@interface RZDebugMenuMultiValueItem ()

@property (strong, nonatomic, readwrite) NSArray *selectionItems;

@end

@implementation RZDebugMenuMultiValueItem

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title andSelectionItems:(NSArray *)selectionItems
{
    self = [super initWithValue:value forKey:key withTitle:title];
    if ( self ) {
        _selectionItems = selectionItems;
    }
    return self;
}

@end
