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
#import "RZDebugMenuTextFieldItem.h"

#import "RZDisclosureTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"
#import "RZTextFieldTableViewCell.h"

static NSString * const kRZUserSettingsDebugPrefix = @"DEBUG_";
static NSString * const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString * const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString * const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";
static NSString * const kRZTextFieldSpecifier = @"PSTextFieldSpecifier";
static NSString * const kRZKeyBundleVersionString = @"CFBundleShortVersionString";
static NSString * const kRZKeyItemIdentifier = @"Key";
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
@property (strong, nonatomic) NSArray *preferenceSpecifiers;

@end

@implementation RZDebugMenuSettingsInterface

- (id)initWithDictionary:(NSDictionary *)plistData
{
    
    self = [super init];
    if ( self ) {
        _settingsCellItemsMetaData = [[NSMutableArray alloc] init];
        _preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
        
        NSMutableDictionary *userSettings = [self createMetaDataObjectsAndGenerateUserDefaults:_preferenceSpecifiers];
        
        [self setUpVersionCellMetaData];
        [[NSUserDefaults standardUserDefaults] registerDefaults:userSettings];
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
    [_settingsOptionsTableView registerClass:[RZTextFieldTableViewCell class] forCellReuseIdentifier:kRZTextFieldSpecifier];
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
        
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSString *multiValueSettingsKey = [self generateSettingsKey:settingsDefaultKey];
        NSNumber *selectionDefaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:multiValueSettingsKey];
        NSInteger defaultValue = [selectionDefaultValue integerValue];
        RZDebugMenuMultiValueItem *currentMultiValueItem = (RZDebugMenuMultiValueItem *)currentMetaDataObject;
        RZMultiValueSelectionItem *currentSelection = [currentMultiValueItem.selectionItems objectAtIndex:defaultValue];
        
        disclosureCell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        disclosureCell.detailTextLabel.text = currentSelection.selectionTitle;
        cell = disclosureCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        RZToggleTableViewCell *toggleCell = (RZToggleTableViewCell *) cell;
        
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSString *toggleDefault = [self generateSettingsKey:settingsDefaultKey];
        NSNumber *toggleSwitchDefaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:toggleDefault];
        
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        toggleCell.applySettingsSwitch.on = [toggleSwitchDefaultValue boolValue];
        cell = toggleCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuTextFieldItem class]] ) {
        //do stuff
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuVersionItem class]] ){
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        cell.detailTextLabel.text = ((RZDebugMenuVersionItem *)currentMetaDataObject).versionNumber;
    }
    return cell;
}

- (void)setValue:(id)value forDebugSettingsKey:(NSString *)key
{
    if ( key != nil && value != nil ) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userDefaultsKey = [self generateSettingsKey:key];
        
        if ( [userDefaults objectForKey:userDefaultsKey] != value ) {
            [userDefaults setObject:value forKey:userDefaultsKey];
        }
    }
}

- (NSMutableDictionary *)createMetaDataObjectsAndGenerateUserDefaults:(NSArray *)preferences
{
    NSMutableDictionary *userSettings = [[NSMutableDictionary alloc] init];
    
    for (id settingsItem in preferences) {
        
        NSString *cellTitle = [settingsItem objectForKey:kRZKeyTitle];
        NSString *currentSettingsItemType = [settingsItem objectForKey:kRZKeyType];
        NSString *plistItemIdentifier = [settingsItem objectForKey:kRZKeyItemIdentifier];
        
        if ( [currentSettingsItemType isEqualToString:kRZMultiValueSpecifier] ) {
            
            NSNumber *cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            NSArray *optionTitles = [settingsItem objectForKey:kRZKeyEnvironmentsTitles];
            NSArray *optionValues = [settingsItem objectForKey:kRZKeyEnvironmentsValues];
            
            NSAssert((optionTitles.count == optionValues.count && (optionTitles.count > 0 && optionValues.count > 0)), @"The disclosure selection arrays must be of non-zero length and equal length. Check to see in the Plist under your MultiValue item that your Titles and Values items are equal in length and are not 0");
            
            NSMutableArray *selectionItems = [self generateMultiValueOptionsArray:optionTitles withValues:optionValues];
            
            RZDebugMenuMultiValueItem *disclosureTableViewCellMetaData = [[RZDebugMenuMultiValueItem alloc] initWithValue:cellDefaultValue
                                                                                                                   forKey:plistItemIdentifier
                                                                                                                withTitle:cellTitle
                                                                                                        andSelectionItems:selectionItems];
            [_settingsCellItemsMetaData addObject:disclosureTableViewCellMetaData];
            
            NSString *multiValueSettingsKey = [self generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:cellDefaultValue forKey:multiValueSettingsKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZToggleSwitchSpecifier] ) {
            
            NSNumber *defaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            
            RZDebugMenuToggleItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithValue:defaultValue
                                                                                                       forKey:plistItemIdentifier
                                                                                                    withTitle:cellTitle];
            
            [_settingsCellItemsMetaData addObject:toggleTableViewCellMetaData];
            
            NSString *toggleKey = [self generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:[settingsItem objectForKey:kRZKeyDefaultValue] forKey:toggleKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZTextFieldSpecifier] ) {
            NSString *defaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            RZDebugMenuTextFieldItem *textFieldTableViewCellMetaData = [[RZDebugMenuTextFieldItem alloc] initWithValue:defaultValue forKey:plistItemIdentifier withTitle:cellTitle];
            [_settingsCellItemsMetaData addObject:textFieldTableViewCellMetaData];
        }
    }
    return userSettings;
}

- (NSMutableArray *)generateMultiValueOptionsArray:(NSArray *)optionTitles withValues:(NSArray *)optionValues
{
    NSMutableArray *selectionItems = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < optionTitles.count; i++) {
        
        NSString *title = [optionTitles objectAtIndex:i];
        NSNumber *value = [optionValues objectAtIndex:i];
        RZMultiValueSelectionItem *selectionItemMetaData = [[RZMultiValueSelectionItem alloc] initWithTitle:title defaultValue:value];
        [selectionItems addObject:selectionItemMetaData];
    }
    return selectionItems;
}

- (void)setUpVersionCellMetaData
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZKeyBundleVersionString];
    RZDebugMenuVersionItem *versionItem = [[RZDebugMenuVersionItem alloc] initWithTitle:kRZVersionCellTitle andVersionNumber:version];
    [_settingsCellItemsMetaData addObject:versionItem];
}

- (RZDebugMenuSettingsItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger numberOfItems = self.settingsCellItemsMetaData.count;
    if ( indexPath.section > 0 || indexPath.row >= numberOfItems ) {
        return nil;
    }
    return [self.settingsCellItemsMetaData objectAtIndex:indexPath.row];
}

- (id)valueForDebugSettingsKey:(NSString *)key
{
    NSString *settingKey = [self generateSettingsKey:key];
    return [[NSUserDefaults standardUserDefaults] objectForKey:settingKey];
}

- (NSString *)generateSettingsKey:(NSString *)identifier
{
    return [NSString stringWithFormat:@"%@%@", kRZUserSettingsDebugPrefix, identifier];
}

- (NSString *)getKeyIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    id setting = [self.preferenceSpecifiers objectAtIndex:indexPath.row];
    
    if ( [setting isKindOfClass:[NSDictionary class]] ) {
        return [setting objectForKey:kRZKeyItemIdentifier];
    }
    return nil;
}

@end
