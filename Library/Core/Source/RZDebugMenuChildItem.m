//
//  RZDebugMenuChildItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuChildItem.h"

@interface RZDebugMenuChildItem ()

@property (copy, nonatomic, readwrite) NSArray *children;

@end

@implementation RZDebugMenuChildItem

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

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [NSMutableDictionary dictionary];

    mutableFieldDictionary[FXFormFieldTitle] = self.title;
    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeDefault;

    return [mutableFieldDictionary copy];
}

- (NSArray *)fxFormsChildMenuItems
{
    return self.children;
}

@end
