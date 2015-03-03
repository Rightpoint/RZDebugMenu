//
//  RZDebugMenuTextSettingItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuTextSettingItem.h"

#import <FXForms/FXForms.h>

@interface RZDebugMenuTextSettingItem ()

@end

@implementation RZDebugMenuTextSettingItem

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
    }
    
    return self;
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeText;

    return [mutableFieldDictionary copy];
}

@end
