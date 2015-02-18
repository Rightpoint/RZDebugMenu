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

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        _textFieldCellDefaultValue = self.value;
    }
    
    return self;
}

@end
