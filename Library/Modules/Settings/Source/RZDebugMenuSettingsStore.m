//
//  RZDebugMenuSettingsStore.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/23/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsStore.h"

@interface RZDebugMenuSettingsStore ()

@property (copy, nonatomic, readwrite) NSArray *keys;
@property (copy, nonatomic, readwrite) NSDictionary *defaultValues;

@end

@implementation RZDebugMenuSettingsStore

- (instancetype)initWithKeys:(NSArray *)keys defaultValues:(NSDictionary *)defaultValues
{
    self = [super init];
    if ( self ) {
        self.keys = keys;
        self.defaultValues = defaultValues;
    }

    return self;
}

- (void)reset
{
    NSAssert(NO, @"Subclass should implement reset.");
}

# pragma mark - Keyed Access

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying, NSObject>)key
{
    NSAssert([key isKindOfClass:[NSString class]], @"");

    [self setValue:obj forKey:(NSString *)key];
}

- (id)objectForKeyedSubscript:(id <NSCopying, NSObject>)key
{
    NSAssert([key isKindOfClass:[NSString class]], @"");

    return [self valueForKey:(NSString *)key];
}

- (id)defaultValueForKey:(id)key
{
    return [self.defaultValues objectForKey:key];
}

- (id)valueForKey:(NSString *)key
{
    id valueToReturn = nil;

    if ( [self.keys containsObject:key] ) {
        valueToReturn = [self.defaultValues objectForKey:key];
    }
    else {
        valueToReturn = [super valueForKey:key];
    }

    return valueToReturn;
}

@end