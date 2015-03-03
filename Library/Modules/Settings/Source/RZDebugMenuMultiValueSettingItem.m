//
//  RZDebugMenuMultiValueSettingItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuMultiValueSettingItem.h"

#import "RZDebugMenuMultiValueSelectionItem.h"
#import "RZDebugMenuShortTitles.h"

#import <FXForms/FXForms.h>

@interface RZDebugMenuMultiValueSettingItem ()

@property (strong, nonatomic, readwrite) NSArray *selectionItems;

@end

@implementation RZDebugMenuMultiValueSettingItem

- (instancetype)initWithDefaultValue:(id)value key:(NSString *)key title:(NSString *)title
{
    return [self initWithValue:value key:key title:title selectionItems:nil];
}

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title selectionItems:(NSArray *)selectionItems
{
    self = [super initWithDefaultValue:value key:key title:title];
    if ( self ) {
        _selectionItems = selectionItems;
    }
    return self;
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    NSArray *selectionItems = self.selectionItems;
    NSArray *longTitles = [selectionItems valueForKey:NSStringFromSelector(@selector(title))];
    NSArray *values = [selectionItems valueForKey:NSStringFromSelector(@selector(value))];
    NSArray *shortTitles = [selectionItems valueForKey:NSStringFromSelector(@selector(shortTitle))];

    BOOL hasShortTitles = [[shortTitles firstObject] isKindOfClass:[NSString class]];

    mutableFieldDictionary[FXFormFieldOptions] = values;

    NSArray *titlesForTransform = longTitles;

    if ( hasShortTitles ) {
        mutableFieldDictionary[FXFormFieldViewController] = [[RZFormLongNameViewController alloc] initWithLongTitles:longTitles];
        titlesForTransform = shortTitles;
    }

    mutableFieldDictionary[FXFormFieldValueTransformer] = ^(id input) {
        NSString *valueToReturn = @"";

        if ( input != nil ) {
            NSUInteger index = [values indexOfObject:input];
            NSAssert(index < NSNotFound && index >= 0, @"");
            valueToReturn = titlesForTransform[index];
        }

        return valueToReturn;
    };

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeDefault;

    return [mutableFieldDictionary copy];
}

@end
