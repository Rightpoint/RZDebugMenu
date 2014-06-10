//
//  RZDebugMenuSettingsInterface.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsInterface.h"

#import "RZDebugMenuSettingsItem.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"

#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"

static NSString * const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString * const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString * const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";
static NSString * const kRZKeyBundleVersionString = @"CFBundleShortVersionString";
static NSString * const kRZKeyTitle = @"Title";
static NSString * const kRZKeyType = @"Type";
static NSString * const kRZKeyDefaultValue = @"DefaultValue";
static NSString * const kRZKeyEnvironmentsTitles = @"Titles";
static NSString * const kRZKeyEnvironmentsValues = @"Values";
static NSString * const kRZVersionCellTitle = @"Version";
static NSString * const kRZDisclosureReuseIdentifier = @"environments";
static NSString * const kRZToggleReuseIdentifier = @"toggle";
static NSString * const kRZVersionInfoReuseIdentifier = @"version";

@interface RZDebugMenuSettingsInterface ()

@property(nonatomic, readwrite, strong) NSMutableArray *settingsCellItemsMetaData;

@end

@implementation RZDebugMenuSettingsInterface

- (id)initWithDictionary:(NSDictionary *)plistData
{
    
    self = [super init];
    if ( self ) {
        
        _settingsCellItemsMetaData = [[NSMutableArray alloc] init];
        
        NSArray *preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
        
        for (id settingsItem in preferenceSpecifiers) {
            
            NSString *cellTitle = [settingsItem objectForKey:kRZKeyTitle];
            
            if ( [[settingsItem objectForKey:kRZKeyType] isEqualToString:kRZMultiValueSpecifier] ) {
                NSNumber *cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
                NSArray *optionTitles = [settingsItem objectForKey:kRZKeyEnvironmentsTitles];
                NSArray *optionValues = [settingsItem objectForKey:kRZKeyEnvironmentsValues];
                RZDebugMenuSettingsItem *disclosureTableViewCellMetaData = [[RZDebugMenuMultiValueItem alloc] initWithTitle:cellTitle
                                                                                                               defaultValue:cellDefaultValue
                                                                                                                 andOptions:optionTitles
                                                                                                                 withValues:optionValues];
                [_settingsCellItemsMetaData addObject:disclosureTableViewCellMetaData];
            }
            else if ( [[settingsItem objectForKey:kRZKeyType] isEqualToString:kRZToggleSwitchSpecifier] ) {
                
                bool cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
                RZDebugMenuSettingsItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithTitle:cellTitle andValue:cellDefaultValue];
                [_settingsCellItemsMetaData addObject:toggleTableViewCellMetaData];
            }
        }
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZKeyBundleVersionString];
        RZDebugMenuSettingsItem *versionItem = [[RZDebugMenuVersionItem alloc] initWithTitle:kRZVersionCellTitle andVersionNumber:version];
        [_settingsCellItemsMetaData addObject:versionItem];
    
        _settingsOptionsTableView.dataSource = self;
    }
    
    return self;
}

#pragma mark - Overridden setters/getters

- (void)setSettingsOptionsTableView:(UITableView *)settingsOptionsTableView
{
    _settingsOptionsTableView = settingsOptionsTableView;
    [_settingsOptionsTableView registerClass:[RZDisclosureTableViewCell class] forCellReuseIdentifier:kRZDisclosureReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZToggleTableViewCell class] forCellReuseIdentifier:kRZToggleReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZVersionInfoTableViewCell class] forCellReuseIdentifier:kRZVersionInfoReuseIdentifier];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.settingsCellItemsMetaData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    RZDebugMenuSettingsItem *currentMetaDataObject = [self.settingsCellItemsMetaData objectAtIndex:indexPath.row];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZDisclosureReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        
        NSInteger defaultValue = [((RZDebugMenuMultiValueItem *)currentMetaDataObject).disclosureTableViewCellDefaultValue integerValue];
        NSString *currentSelection = [((RZDebugMenuMultiValueItem *)currentMetaDataObject).selectionTitles objectAtIndex:(unsigned long)defaultValue];
        cell.detailTextLabel.text = currentSelection;
        
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuVersionItem class]] ){
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        cell.detailTextLabel.text = ((RZDebugMenuVersionItem *)currentMetaDataObject).versionNumber;
    }
    
    return cell;
}

#pragma mark - other methods

- (RZDebugMenuSettingsItem *)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.settingsCellItemsMetaData objectAtIndex:indexPath.row];
}

@end
