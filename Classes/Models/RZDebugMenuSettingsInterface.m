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
        
        NSArray *preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
        
        NSMutableDictionary *userSettings = [[NSMutableDictionary alloc] init];
        NSNumber *numberDisclosureCells = [[NSNumber alloc] initWithInt:0];
        NSNumber *numberToggleCells = [[NSNumber alloc] initWithInt:0];
        
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
                
                NSString *disclosureKey = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZMultiValueSpecifier, [numberDisclosureCells intValue]];
                [userSettings setObject:[settingsItem objectForKey:kRZDefaultValueSpecifier] forKey:disclosureKey];
                numberDisclosureCells = [NSNumber numberWithInt:[numberDisclosureCells intValue]+1];
            }
            else if ( [currentSettingsItemType isEqualToString:kRZToggleSwitchSpecifier] ) {
                
                RZDebugMenuSettingsItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithTitle:cellTitle];
                [_settingsCellItemsMetaData addObject:toggleTableViewCellMetaData];
                
                NSString *toggleKey = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZToggleSwitchSpecifier, [numberToggleCells intValue]];
                [userSettings setObject:[settingsItem objectForKey:kRZDefaultValueSpecifier] forKey:toggleKey];
                numberToggleCells = [NSNumber numberWithInt:[numberToggleCells intValue]+1];
            }
        }
        
        NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:kRZKeyBundleVersionString];
        RZDebugMenuSettingsItem *versionItem = [[RZDebugMenuVersionItem alloc] initWithTitle:kRZVersionCellTitle andVersionNumber:version];
        [_settingsCellItemsMetaData addObject:versionItem];
        
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
        
        NSString *multiValueSettingsKey = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZMultiValueSpecifier, indexPath.row];
        NSNumber *selectionDefaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:multiValueSettingsKey];
        NSInteger defaultValue = [selectionDefaultValue integerValue];
        RZMultiValueSelectionItem *currentSelection = [currentMultiValueItem.selectionItems objectAtIndex:defaultValue];
        
        disclosureCell.detailTextLabel.text = currentSelection.selectionTitle;
        cell = disclosureCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.tableViewCellTitle;
        
        RZToggleTableViewCell *toggleCell = (RZToggleTableViewCell *) cell;
        
        NSString *toggleDefault = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZToggleSwitchSpecifier, indexPath.row];
        NSNumber *toggleSwitchDefaultValue = [[NSUserDefaults standardUserDefaults] objectForKey:toggleDefault];
        
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
    NSString *valueToChange = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZToggleSwitchSpecifier, currentCellIndexPath.row];
    [mutableUserDefaults setObject:toggleSwitchValue forKey:valueToChange];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:mutableUserDefaults];
    NSLog(@"%@: %@", valueToChange, [[NSUserDefaults standardUserDefaults] objectForKey:valueToChange]);
}

- (void)didMakeNewSelection:(RZMultiValueSelectionItem *)item withIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *mutableUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] mutableCopy];

    // TODO: Get index path of the disclosure cell on the main menu
    NSString *valueToChange = [NSString stringWithFormat:@"%@%@%i", @"DEBUG", kRZMultiValueSpecifier, indexPath.row-1];
    [mutableUserDefaults setValue:item.selectionValue forKey:valueToChange];
    
    NSArray *visible = [self.settingsOptionsTableView indexPathsForVisibleRows];
    NSIndexPath *test = [visible objectAtIndex:0];
    UITableViewCell *currentDisclosureCell = [self.settingsOptionsTableView cellForRowAtIndexPath:test];
    currentDisclosureCell.detailTextLabel.text = item.selectionTitle;
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:mutableUserDefaults];
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
