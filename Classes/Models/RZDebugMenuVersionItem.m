//
//  RZDebugMenuVersionItem.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//
// NOTE: This class is READONLY and can not be altered via any interfaces

#import "RZDebugMenuVersionItem.h"

static NSString *const kRZVersionNotFound = @"Not Found";
static NSString *const kRZVersionFormat = @"%@ (%@)";

static NSString *const kRZCFBundleVersionKey = @"CFBundleVersion";
static NSString *const kRZCFBundleShortVersionStringKey = @"CFBundleShortVersionString";
static NSString *const kRZCFBundleNameKey = @"CFBundleName";

@interface RZDebugMenuVersionItem ()

@property (copy, nonatomic, readwrite) NSString *versionString;

@end

@implementation RZDebugMenuVersionItem

- (instancetype)initWithVersionString:(NSString *)versionString
{
    self = [super initWithTitle:[[self class] applicationName]];
    if ( self ) {
        _versionString = versionString;
    }
    return self;
}

+ (NSString *)applicationName
{
    NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZCFBundleNameKey];
    if ( name.length == 0 ) {
        name = kRZVersionNotFound;
    }

    return name;
}

+ (NSString *)versionString
{
    NSString *versionString = kRZVersionNotFound;

    NSString *shortVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZCFBundleShortVersionStringKey];
    if ( shortVersionString.length > 0 ) {
        versionString = shortVersionString;
    }

    NSString *bundleVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZCFBundleVersionKey];
    if ( bundleVersionString.length > 0 && [shortVersionString isEqualToString:versionString] == NO ) {
        if ( shortVersionString.length > 0 ) {
            versionString = [NSString stringWithFormat:kRZVersionFormat, shortVersionString, bundleVersionString];
        }
        else {
            versionString = bundleVersionString;
        }
    }

    return versionString;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self init];
}

- (instancetype)init
{
    return [self initWithVersionString:[[self class] versionString]];
}

@end
