//
//  RZMultiValueSelectionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZMultiValueSelectionItem.h"

@interface RZMultiValueSelectionItem ()

@property (strong, nonatomic, readwrite) NSString *selectionTitle;
@property (strong, nonatomic, readwrite) id selectionValue;

@end

@implementation RZMultiValueSelectionItem

- (id)initWithTitle:(NSString *)title defaultValue:(id)value
{
    self = [super init];
    if ( self ) {
        _selectionTitle = title;
        _selectionValue = value;
    }
    return self;
}

@end
