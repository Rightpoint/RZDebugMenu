//
//  RZDebugMenuSettingItem.m
//  Pods
//
//  Created by Michael Gorbach on 2/17/15.
//
//

#import "RZDebugMenuSettingItem.h"

#import <FXForms/FXForms.h>

@implementation RZDebugMenuSettingItem

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super initWithTitle:title];
    if ( self ) {
        _key = key;
        _value = value;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithValue:nil key:nil title:title];
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    NSString *key = self.key;
    if ( key.length > 0 ) {
        mutableFieldDictionary[FXFormFieldKey] = key;
    }

    id defaultValue = self.value;
    if ( defaultValue ) {
        mutableFieldDictionary[FXFormFieldDefaultValue] = defaultValue;
    }

    return [mutableFieldDictionary copy];
}

@end
