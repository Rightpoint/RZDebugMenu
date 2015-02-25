//
//  RZDebugMenuToggleItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuToggleItem.h"

@interface RZDebugMenuToggleItem ()

@property (strong, nonatomic, readwrite) id trueValue;
@property (strong, nonatomic, readwrite) id falseValue;

@end

@implementation RZDebugMenuToggleItem

- (id)initWithValue:(id)value
                key:(NSString *)key
              title:(NSString *)title
          trueValue:(id)trueValue
         falseValue:(id)falseValue
{
    self = [super initWithValue:value key:key title:title];
    if ( self ) {
        self.trueValue = trueValue;
        self.falseValue = falseValue;
    }
    
    return self;
}

- (id)initWithValue:(id)value key:(NSString *)key title:(NSString *)title
{
    return [self initWithValue:value key:key title:title trueValue:nil falseValue:nil];
}

@end
