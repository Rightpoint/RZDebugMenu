//
//  RZDebugMenuTextFieldItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuTextFieldItem.h"

@interface RZDebugMenuTextFieldItem ()

@property (strong, nonatomic, readwrite) NSString *textFieldCellDefaultValue;

@end

@implementation RZDebugMenuTextFieldItem

- (id)initWithValue:(id)value forKey:(NSString *)key withTitle:(NSString *)title
{
    self = [super initWithValue:value forKey:key withTitle:title];
    if ( self ) {
        _textFieldCellDefaultValue = self.settingsValue;
    }
    return self;
}

@end
