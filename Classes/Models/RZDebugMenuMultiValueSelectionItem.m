//
//  RZDebugMenuMultiValueSelectionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiValueSelectionItem.h"

@interface RZDebugMenuMultiValueSelectionItem ()

@property (strong, nonatomic, readwrite) id value;

@end

@implementation RZDebugMenuMultiValueSelectionItem

- (id)initWithTitle:(NSString *)title value:(id)value
{
    self = [super initWithTitle:title];
    if ( self ) {
        self.value = value;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title value:nil];
}

@end
