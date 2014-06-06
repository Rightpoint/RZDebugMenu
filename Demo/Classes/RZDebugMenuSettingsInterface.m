//
//  RZDebugMenuSettingsInterface.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsInterface.h"

static NSString * const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString * const kRZKeyTitle = @"Title";
static NSString * const kRZKeyDefaultValue = @"DefaultValue";
static NSString * const kRZKeyEnvironmentsTitles = @"Titles";
static NSString * const kRZKeyEnvironmentsValues = @"Values";

@implementation RZDebugMenuSettingsInterface

- (id)initWithDictionary:(NSDictionary *)plistData {
    
    NSArray *preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
    NSDictionary *disclosureCellData = [preferenceSpecifiers objectAtIndex:0];
    NSDictionary *toggleCellData = [preferenceSpecifiers objectAtIndex:1];
    
    _disclosureTableViewCellTitle = [disclosureCellData objectForKey:kRZKeyTitle];
    _disclosureTableViewCellDefaultValue = [disclosureCellData objectForKey:kRZKeyDefaultValue];
    _environmentNames = [disclosureCellData objectForKey:kRZKeyEnvironmentsTitles];
    _environmentValues = [disclosureCellData objectForKey:kRZKeyEnvironmentsValues];
    _toggleTableViewCellTitle = [toggleCellData objectForKey:kRZKeyTitle];
    _toggleTableViewCellDefaultValue = [toggleCellData objectForKey:kRZKeyDefaultValue];
    
    return self;
}

@end
