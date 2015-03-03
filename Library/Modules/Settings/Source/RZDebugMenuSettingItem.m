//
//  RZDebugMenuSettingItem.m
//  Pods
//
//  Created by Michael Gorbach on 2/17/15.
//
//

#import "RZDebugMenuSettingItem.h"

#import "RZDebugMenuSettings.h"

#import <FXForms/FXForms.h>

@implementation RZDebugMenuSettingItem

- (instancetype)initWithDefaultValue:(id)value key:(NSString *)key title:(NSString *)title
{
    NSAssert(key.length > 0, @"");

    self = [super initWithTitle:title];
    if ( self ) {
        _key = key;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithDefaultValue:nil key:nil title:title];
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

- (void)updateValue:(id)value
{
    [RZDebugMenuSettings sharedSettings][self.key] = value;
}

- (id)value
{
    return [RZDebugMenuSettings sharedSettings][self.key];
}

@end
