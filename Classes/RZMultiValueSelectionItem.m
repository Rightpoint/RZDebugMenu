//
//  RZMultiValueSelectionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZMultiValueSelectionItem.h"

@interface RZMultiValueSelectionItem ()

@property(nonatomic, readwrite, strong) NSString *selectionTitle;
@property(nonatomic, readwrite, strong) NSNumber *selectionValue;

@end

@implementation RZMultiValueSelectionItem

- (id)initWithTitle:(NSString *)title andValue:(NSNumber *)value
{
    self = [super init];
    if ( self ) {
        _selectionTitle = title;
        _selectionValue = value;
    }
    return self;
}

@end
