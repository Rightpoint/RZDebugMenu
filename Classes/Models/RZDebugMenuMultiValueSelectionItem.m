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
@property (copy, nonatomic, readwrite) NSString *shortTitle;

@end

@implementation RZDebugMenuMultiValueSelectionItem

- (id)initWithLongTitle:(NSString *)longTitle shortTitle:(NSString *)shortTitle value:(id)value
{
    self = [super initWithTitle:longTitle];
    if ( self ) {
        self.shortTitle = shortTitle;
        self.value = value;
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
{
    return [self initWithLongTitle:title shortTitle:nil value:nil];
}

@end
