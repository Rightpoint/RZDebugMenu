//
//  RZMultiValueSelectionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZMultiValueSelectionItem.h"

@interface RZMultiValueSelectionItem ()

@property(nonatomic, readonly, strong) NSString *selectionTitle;
@property(nonatomic, readonly, strong) NSString *selectionValue;

@end

@implementation RZMultiValueSelectionItem

- (id)initWithTitle:(NSString *)title andValue:(NSString *)value
{
    self = [super init];
    if ( self ) {
        // TODO: setup object here
    }
    return self;
}

@end
