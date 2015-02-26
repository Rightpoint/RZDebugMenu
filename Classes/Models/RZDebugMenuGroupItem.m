//
//  RZDebugMenuGroupItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuGroupItem.h"

@interface RZDebugMenuGroupItem ()

@property (copy, nonatomic, readwrite) NSArray *children;

@end

@implementation RZDebugMenuGroupItem

- (instancetype)initWithTitle:(NSString *)title children:(NSArray *)children
{
    self = [super initWithTitle:title];
    if ( self ) {
        self.children = children;
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title children:nil];
}

@end
