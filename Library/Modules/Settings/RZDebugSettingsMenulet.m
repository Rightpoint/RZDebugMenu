//
//  RZDebugSettingsMenulet.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/3/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugSettingsMenulet.h"

#import "RZDebugMenuSettingsParser.h"
#import "RZDebugMenuSettings_Private.h"

@interface RZDebugSettingsMenulet ()

@property (copy, nonatomic, readwrite) NSArray *menuItems;

@end

@implementation RZDebugSettingsMenulet

- (instancetype)initWithSettingsPlistName:(NSString *)plistName
{
    self = [super init];
    if ( self ) {
        NSAssert(plistName.length > 0, @"");

        [self loadSettingsMenuFromPlistName:plistName];
    }

    return self;
}

- (void)loadSettingsMenuFromPlistName:(NSString *)plistName
{
    NSError *settingsParsingError = nil;
    NSArray *keys = nil;
    NSDictionary *defaultValues = nil;

    NSArray *settingsMenuItems = [RZDebugMenuSettingsParser settingsMenuItemsFromPlistName:plistName
                                                                             returningKeys:&keys
                                                                             defaultValues:&defaultValues
                                                                                     error:&settingsParsingError];
    if ( settingsMenuItems ) {
        // We've loaded all our settings. Initialize the store.
        [RZDebugMenuSettings initializeWithKeys:keys defaultValues:defaultValues];
    }
    else {
        NSLog(@"Failed to parse settings from plist %@: %@.", plistName, settingsParsingError);
    }

    self.menuItems = settingsMenuItems;
}

@end
