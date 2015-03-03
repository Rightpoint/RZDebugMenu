//
//  RZDebugMenuToggleSettingItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuToggleSettingItem.h"

#import <FXForms/FXForms.h>

@interface RZDebugMenuToggleSettingItem ()

@property (strong, nonatomic, readwrite) id trueValue;
@property (strong, nonatomic, readwrite) id falseValue;

@end

@implementation RZDebugMenuToggleSettingItem

- (instancetype)initWithValue:(id)value
                key:(NSString *)key
              title:(NSString *)title
          trueValue:(id)trueValue
         falseValue:(id)falseValue
{
    self = [super initWithDefaultValue:value key:key title:title];
    if ( self ) {
        self.trueValue = trueValue;
        self.falseValue = falseValue;
    }
    
    return self;
}

- (instancetype)initWithDefaultValue:(id)value key:(NSString *)key title:(NSString *)title
{
    return [self initWithValue:value key:key title:title trueValue:nil falseValue:nil];
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeBoolean;

    return [mutableFieldDictionary copy];
}

- (void)updateValue:(id)value
{
    id trueValue = self.trueValue;
    id falseValue = self.falseValue;

    if ( trueValue ) {
        NSAssert(falseValue != nil, @"");
        NSAssert([trueValue class] == [falseValue class], @"");

        id (^reverseValueTransformer)(NSNumber *value) = ^(NSNumber *value) {
            id valueToReturn = falseValue;

            NSAssert([value isKindOfClass:[NSNumber class]], @"");

            if ( [value boolValue] ) {
                valueToReturn = trueValue;
            }

            return valueToReturn;
        };

        value = reverseValueTransformer(value);
    }

    [super updateValue:value];
}

@end
