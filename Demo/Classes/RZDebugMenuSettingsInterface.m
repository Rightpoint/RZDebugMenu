//
//  RZDebugMenuSettingsInterface.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsInterface.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"

static NSString * const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString * const kRZKeyTitle = @"Title";
static NSString * const kRZKeyDefaultValue = @"DefaultValue";
static NSString * const kRZKeyEnvironmentsTitles = @"Titles";
static NSString * const kRZKeyEnvironmentsValues = @"Values";

@implementation RZDebugMenuSettingsInterface

- (id)initWithDictionary:(NSDictionary *)plistData
{
    
    self = [super init];
    if ( self ) {
        _settingsCellItems = [[NSMutableArray alloc] init];
        NSArray *preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
        
        for (id settingsItem in preferenceSpecifiers) {
            
            NSString *cellTitle = [settingsItem objectForKey:kRZKeyTitle];
            
            if ( [[settingsItem objectForKey:@"Type"] isEqualToString:@"PSMultiValueSpecifier"] ) {
                NSNumber *cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
                NSArray *optionTitles = [settingsItem objectForKey:kRZKeyEnvironmentsTitles];
                NSArray *optionValues = [settingsItem objectForKey:kRZKeyEnvironmentsValues];
                RZDebugMenuMultiValueItem *disclosureTableViewCellMetaData = [[RZDebugMenuMultiValueItem alloc] initWithTitle:cellTitle
                                                                                                                 defaultValue:cellDefaultValue
                                                                                                                   andOptions:optionTitles
                                                                                                                   withValues:optionValues];
                [_settingsCellItems addObject:disclosureTableViewCellMetaData];
            }
            else if ( [[settingsItem objectForKey:@"Type"] isEqualToString:@"PSToggleSwitchSpecifier"] ) {
                BOOL cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
                RZDebugMenuToggleItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithTitle:cellTitle andValue:cellDefaultValue];
                [_settingsCellItems addObject:toggleTableViewCellMetaData];
            }
        }
        NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
        [_settingsCellItems addObject:version];
    }
    return self;
}

@end
