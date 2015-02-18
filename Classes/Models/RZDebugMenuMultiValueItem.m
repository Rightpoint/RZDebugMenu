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

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title selectionItems:(NSArray *)selectionItems
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        _selectionItems = selectionItems;
    }
    return self;
}

@end
