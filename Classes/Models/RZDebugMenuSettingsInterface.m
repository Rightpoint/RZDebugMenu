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
//#import "RZMultiValueSelectionItem.h"

#import "RZDisclosureTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"

static NSString * const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString * const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString * const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";
static NSString * const kRZDefaultValueSpecifier = @"DefaultValue";
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

@property (strong, nonatomic, readwrite) NSMutableArray *settingsCellItemsMetaData;

@end

@implementation RZDebugMenuSettingsInterface

- (id)initWithDictionary:(NSDictionary *)plistData
{
    
    self = [super init];
    if ( self ) {
        _settingsCellItemsMetaData = [[NSMutableArray alloc] init];
        
        NSArray *preferenceSpecifiers = [[NSUserDefaults standardUserDefaults] objectForKey:kRZPreferenceSpecifiersKey];
        
        for (id settingsItem in preferenceSpecifiers) {
            NSString *cellTitle = [settingsItem objectForKey:kRZKeyTitle];
            NSString *currentSettingsItemType = [settingsItem objectForKey:kRZKeyType];
            
            if ( [currentSettingsItemType isEqualToString:kRZMultiValueSpecifier] ) {
                NSNumber *cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
                NSArray *optionTitles = [settingsItem objectForKey:kRZKeyEnvironmentsTitles];
                NSArray *optionValues = [settingsItem objectForKey:kRZKeyEnvironmentsValues];
                
                NSAssert((optionTitles.count == optionValues.count && (optionTitles.count > 0 && optionValues.count > 0)), @"The disclosure selection arrays must be of non-zero length and equal length. Check to see in the Plist under your MultiValue item that your Titles and Values items are equal in length and are not 0");
                
                NSMutableArray *selectionItems = [[NSMutableArray alloc] init];
                
                for (int i = 0; i < optionTitles.count; i++) {
                    NSString *title = [optionTitles objectAtIndex:i];
                    NSNumber *value = [optionValues objectAtIndex:i];
                    
                    RZMultiValueSelectionItem *selectionItemMetaData = [[RZMultiValueSelectionItem alloc] initWithTitle:title defaultValue:value];
                    selectionItemMetaData.delegate = self;
                    [selectionItems addObject:selectionItemMetaData];
                }
                
                RZDebugMenuSettingsItem *disclosureTableViewCellMetaData = [[RZDebugMenuMultiValueItem alloc] initWithTitle:cellTitle
                                                                                                               defaultValue:cellDefaultValue
                                                                                                          andSelectionItems:selectionItems];
                [_settingsCellItemsMetaData addObject:disclosureTableViewCellMetaData];
            }
            else if ( [currentSettingsItemType isEqualToString:kRZToggleSwitchSpecifier] ) {
                
                RZDebugMenuSettingsItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithTitle:cellTitle];
                [_settingsCellItemsMetaData addObject:toggleTableViewCellMetaData];
            }
        }
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZKeyBundleVersionString];
        RZDebugMenuSettingsItem *versionItem = [[RZDebugMenuVersionItem alloc] initWithTitle:kRZVersionCellTitle andVersionNumber:version];
        [_settingsCellItemsMetaData addObject:versionItem];
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
        RZDisclosureTableViewCell *disclosureCell = (RZDisclosureTableViewCell *)cell;
        disclosureCell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        
        RZDebugMenuMultiValueItem *currentMultiValueItem = (RZDebugMenuMultiValueItem *)currentMetaDataObject;
        
        NSNumber *selectionDefaultValue = [[[[NSUserDefaults standardUserDefaults] objectForKey:kRZPreferenceSpecifiersKey] objectAtIndex:indexPath.row] objectForKey:kRZDefaultValueSpecifier];
        
        NSInteger defaultValue = [selectionDefaultValue integerValue];
        RZMultiValueSelectionItem *currentSelection = [currentMultiValueItem.selectionItems objectAtIndex:(unsigned long)defaultValue];
        disclosureCell.detailTextLabel.text = currentSelection.selectionTitle;
        cell = disclosureCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        
        RZToggleTableViewCell *toggleCell = (RZToggleTableViewCell *) cell;
        
        NSNumber *toggleSwitchDefaultValue = [[[[NSUserDefaults standardUserDefaults] objectForKey:kRZPreferenceSpecifiersKey] objectAtIndex:indexPath.row] objectForKey:kRZDefaultValueSpecifier];
        toggleCell.applySettingsSwitch.on = [toggleSwitchDefaultValue boolValue];
        toggleCell.delegate = self;
        cell = toggleCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuVersionItem class]] ){
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        cell.detailTextLabel.text = ((RZDebugMenuVersionItem *)currentMetaDataObject).versionNumber;
    }
    
    return cell;
}

#pragma mark - RZToggleTableViewCellDelegate method

- (void)didChangeToggleStateOfCell:(RZToggleTableViewCell *)cell
{
    NSIndexPath *currentCellIndexPath = [self.settingsOptionsTableView indexPathForCell:cell];
    NSNumber *toggleSwitchValue = [NSNumber numberWithBool:cell.applySettingsSwitch.on];
    
    NSMutableDictionary *mutableUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] mutableCopy];
    NSMutableArray *settingsArray = [[mutableUserDefaults objectForKey:kRZPreferenceSpecifiersKey] mutableCopy];
    NSMutableDictionary *currentSettingDict = [[[mutableUserDefaults objectForKey:kRZPreferenceSpecifiersKey] objectAtIndex:currentCellIndexPath.row] mutableCopy];
    [currentSettingDict setValue:toggleSwitchValue forKey:kRZDefaultValueSpecifier];
    [settingsArray replaceObjectAtIndex:currentCellIndexPath.row withObject:currentSettingDict];
    [mutableUserDefaults setObject:settingsArray forKey:kRZPreferenceSpecifiersKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:mutableUserDefaults];
    
}

- (void)didMakeNewSelection:(NSIndexPath *)indexPath
{
    NSMutableDictionary *mutableUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] mutableCopy];
    NSMutableArray *settingsArray = [[mutableUserDefaults objectForKey:kRZPreferenceSpecifiersKey] mutableCopy];
    NSMutableDictionary *currentSettingDict = [[[mutableUserDefaults objectForKey:kRZPreferenceSpecifiersKey] objectAtIndex:indexPath.row] mutableCopy];
    [currentSettingDict setValue:[NSNumber numberWithInt:indexPath.row] forKey:kRZDefaultValueSpecifier];
    
    [settingsArray replaceObjectAtIndex:indexPath.row withObject:currentSettingDict];
    [mutableUserDefaults setObject:settingsArray forKey:kRZPreferenceSpecifiersKey];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:mutableUserDefaults];
    
    NSLog(@"%i", indexPath.row);
    
    UITableViewCell *currentDisclosureCell = [self.settingsOptionsTableView cellForRowAtIndexPath:indexPath];
    currentDisclosureCell.detailTextLabel.text = [[currentSettingDict objectForKey:kRZKeyEnvironmentsTitles] objectAtIndex:indexPath.row];
}

#pragma mark - other methods

- (RZDebugMenuSettingsItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger numberOfItems = self.settingsCellItemsMetaData.count;
    if ( indexPath.section > 0 || indexPath.row >= numberOfItems ) {
        return nil;
    }
    return [self.settingsCellItemsMetaData objectAtIndex:indexPath.row];
}

@end
