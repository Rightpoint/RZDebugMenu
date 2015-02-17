//
//  RZDebugMenuSettingItem.m
//  Pods
//
//  Created by Michael Gorbach on 2/17/15.
//
//

#import "RZDebugMenuSettingItem.h"

@implementation RZDebugMenuSettingItem

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    self = [super initWithTitle:title];
    if ( self ) {
        _key = key;
        _value = value;
    }

    return self;
}

- (id)initWithTitle:(NSString *)title
{
    return [self initWithValue:nil key:nil title:title];
}

@end
