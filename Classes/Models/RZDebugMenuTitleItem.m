//
//  RZDebugMenuTitleItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/25/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuTitleItem.h"

@interface RZDebugMenuTitleItem ()

@property (copy, nonatomic, readwrite) NSArray *values;
@property (copy, nonatomic, readwrite) NSArray *titles;

@end

@implementation RZDebugMenuTitleItem

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title values:(NSArray *)values titles:(NSArray *)titles
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        self.values = values;
        self.titles = titles;
    }

    return self;
}

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    return [self initWithValue:value key:key title:title values:nil titles:nil];
}

@end
