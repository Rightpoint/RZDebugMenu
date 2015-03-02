//
//  RZDebugMenuSettingsItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

#import <FXForms/FXForms.h>

@implementation RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if ( self ) {
        _title = title;
    }

    return self;
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSString *title = self.title;
    if ( title.length == 0 ) {
        title = @"";
    }

    NSDictionary *fieldDictionary = @{ FXFormFieldTitle: title };
    return fieldDictionary;
}

- (NSArray *)fxFormsChildMenuItems
{
    return nil;
}

@end
