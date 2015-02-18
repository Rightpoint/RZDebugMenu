//
//  RZDebugMenuSettingsDataSource.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/15/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingsDataSource.h"

#import "RZDebugMenu.h"
#import "RZDebugMenuItem.h"
#import "RZDebugMenuMultiValueItem.h"
#import "RZMultiValueSelectionItem.h"
#import "RZDebugMenuToggleItem.h"
#import "RZDebugMenuVersionItem.h"
#import "RZDebugMenuTextFieldItem.h"
#import "RZDebugMenuSliderItem.h"
#import "RZDebugMenuGroupItem.h"

#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"
#import "RZTextFieldTableViewCell.h"
#import "RZSliderTableViewCell.h"

#import "RZDebugMenuSettingsObserverManager.h"
#import "RZDebugMenuSettingsInterface.h"

static NSString* const kRZPreferenceSpecifiersKey = @"PreferenceSpecifiers";
static NSString* const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString* const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";
static NSString* const kRZTextFieldSpecifier = @"PSTextFieldSpecifier";
static NSString* const kRZSliderSpecifier = @"PSSliderSpecifier";
static NSString* const kRZGroupSpecifer = @"PSGroupSpecifier";

static NSString* const kRZKeyBundleVersionString = @"CFBundleShortVersionString";

static NSString* const kRZKeyItemIdentifier = @"Key";
static NSString* const kRZKeyTitle = @"Title";
static NSString* const kRZKeyType = @"Type";
static NSString* const kRZKeyDefaultValue = @"DefaultValue";
static NSString* const kRZKeyEnvironmentsTitles = @"Titles";
static NSString* const kRZKeyEnvironmentsValues = @"Values";
static NSString* const kRZKeyMaximumValue = @"MaximumValue";
static NSString* const kRZKeyMinimumValue = @"MinimumValue";

static NSString* const kRZVersionCellTitle = @"Version";
static NSString* const kRZVersionGroupTitle = @"Version Info";

static NSString* const kRZDisclosureReuseIdentifier = @"RZSettingsDisclosureCell";
static NSString* const kRZToggleReuseIdentifier = @"RZSettingsToggleSwitchCell";
static NSString* const kRZTextFieldReuseIdentifier = @"RZSettingsTextFieldCell";
static NSString* const kRZSliderReuseIdentifier = @"RZSettingsSliderCell";
static NSString* const kRZVersionInfoReuseIdentifier = @"RZSettingsVersionCell";

static NSString* const kRZEmptyString = @"";

@interface RZDebugMenuSettingsDataSource ()

@property (strong, nonatomic) NSArray *preferenceSpecifiers;
@property (strong, nonatomic, readwrite) NSMutableDictionary *groupedSections;
@property (strong, nonatomic, readwrite) NSMutableArray *sectionGroupTitles;

@end

@implementation RZDebugMenuSettingsDataSource

- (id)initWithDictionary:(NSDictionary *)plistData
{
    
    self = [super init];
    if ( self ) {
        _preferenceSpecifiers = [plistData objectForKey:kRZPreferenceSpecifiersKey];
        _settingsKeys = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *userSettings = [self createMetaDataObjectsAndGenerateUserDefaults:_preferenceSpecifiers];
        [[NSUserDefaults standardUserDefaults] registerDefaults:userSettings];
        
        [self setUpVersionCellMetaData];
    }
    
    return self;
}

- (void)setSettingsOptionsTableView:(UITableView *)settingsOptionsTableView
{
    _settingsOptionsTableView = settingsOptionsTableView;
    [_settingsOptionsTableView registerClass:[RZDisclosureTableViewCell class] forCellReuseIdentifier:kRZDisclosureReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZToggleTableViewCell class] forCellReuseIdentifier:kRZToggleReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZVersionInfoTableViewCell class] forCellReuseIdentifier:kRZVersionInfoReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZTextFieldTableViewCell class] forCellReuseIdentifier:kRZTextFieldReuseIdentifier];
    [_settingsOptionsTableView registerClass:[RZSliderTableViewCell class] forCellReuseIdentifier:kRZSliderReuseIdentifier];
}

#pragma mark - Model generation methods

- (NSMutableDictionary *)createMetaDataObjectsAndGenerateUserDefaults:(NSArray *)preferences
{
    NSMutableDictionary *userSettings = [[NSMutableDictionary alloc] init];
    NSString *currentSection = [[NSString alloc] init];
    self.groupedSections = [[NSMutableDictionary alloc] init];
    self.sectionGroupTitles = [[NSMutableArray alloc] init];
    
    NSDictionary *item = [preferences firstObject];
    if ( ![[item objectForKey:kRZKeyType] isEqualToString:kRZGroupSpecifer] ) {
        NSMutableArray *rows = [[NSMutableArray alloc] init];
        [self.groupedSections setObject:rows forKey:kRZEmptyString];
        currentSection = kRZEmptyString;
        [self.sectionGroupTitles addObject:kRZEmptyString];
    }
    
    for (id settingsItem in preferences) {
        
        NSString *cellTitle = [settingsItem objectForKey:kRZKeyTitle];
        NSString *currentSettingsItemType = [settingsItem objectForKey:kRZKeyType];
        NSString *plistItemIdentifier = [settingsItem objectForKey:kRZKeyItemIdentifier];
        
        if ( plistItemIdentifier != nil ) {
            [self.settingsKeys addObject:plistItemIdentifier];
        }
        
        if ( [currentSettingsItemType isEqualToString:kRZMultiValueSpecifier] ) {
            
            NSNumber *cellDefaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            NSArray *optionTitles = [settingsItem objectForKey:kRZKeyEnvironmentsTitles];
            NSArray *optionValues = [settingsItem objectForKey:kRZKeyEnvironmentsValues];
            
            NSAssert((optionTitles.count == optionValues.count && (optionTitles.count > 0 && optionValues.count > 0)), @"The disclosure selection arrays must be of non-zero length and equal length. Check to see in the Plist under your MultiValue item that your Titles and Values items are equal in length and are not 0");
            
            NSMutableArray *selectionItems = [self generateMultiValueOptionsArray:optionTitles withValues:optionValues];
            
            RZDebugMenuMultiValueItem *disclosureTableViewCellMetaData = [[RZDebugMenuMultiValueItem alloc] initWithValue:cellDefaultValue
                                                                                                                   key:plistItemIdentifier
                                                                                                                title:cellTitle
                                                                                                        selectionItems:selectionItems];
            
            NSMutableArray *objectsInSection = [self.groupedSections objectForKey:currentSection];
            [objectsInSection addObject:disclosureTableViewCellMetaData];
            
            NSString *multiValueSettingsKey = [RZDebugMenuSettingsInterface generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:cellDefaultValue forKey:multiValueSettingsKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZToggleSwitchSpecifier] ) {
            
            NSNumber *defaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            
            RZDebugMenuToggleItem *toggleTableViewCellMetaData = [[RZDebugMenuToggleItem alloc] initWithValue:defaultValue
                                                                                                       key:plistItemIdentifier
                                                                                                    title:cellTitle];
            
            NSMutableArray *objectsInSection = [self.groupedSections objectForKey:currentSection];
            [objectsInSection addObject:toggleTableViewCellMetaData];
            
            NSString *toggleKey = [RZDebugMenuSettingsInterface generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:[settingsItem objectForKey:kRZKeyDefaultValue] forKey:toggleKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZTextFieldSpecifier] ) {
            
            NSString *defaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            RZDebugMenuTextFieldItem *textFieldTableViewCellMetaData = [[RZDebugMenuTextFieldItem alloc] initWithValue:defaultValue
                                                                                                                key:plistItemIdentifier
                                                                                                             title:cellTitle];
            
            NSMutableArray *objectsInSection = [self.groupedSections objectForKey:currentSection];
            [objectsInSection addObject:textFieldTableViewCellMetaData];
            
            NSString *textFieldSettingsKey = [RZDebugMenuSettingsInterface generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:defaultValue forKey:textFieldSettingsKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZSliderSpecifier] ) {
            
            NSNumber *defaultValue = [settingsItem objectForKey:kRZKeyDefaultValue];
            NSNumber *maximum = [settingsItem objectForKey:kRZKeyMaximumValue];
            NSNumber *minimum = [settingsItem objectForKey:kRZKeyMinimumValue];
            
            RZDebugMenuSliderItem *sliderTableViewCellMetaData = [[RZDebugMenuSliderItem alloc] initWithValue:defaultValue
                                                                                                       key:plistItemIdentifier
                                                                                                    title:cellTitle
                                                                                                     maxValue:maximum
                                                                                                     minValue:minimum];
            
            NSMutableArray *objectsInSection = [self.groupedSections objectForKey:currentSection];
            [objectsInSection addObject:sliderTableViewCellMetaData];
            
            NSString *sliderSettingsKey = [RZDebugMenuSettingsInterface generateSettingsKey:plistItemIdentifier];
            [userSettings setObject:defaultValue forKey:sliderSettingsKey];
        }
        else if ( [currentSettingsItemType isEqualToString:kRZGroupSpecifer] ) {
            
            currentSection = cellTitle;
            NSMutableArray *rows = [self.groupedSections objectForKey:cellTitle];
            if ( !rows ) {
                rows = [[NSMutableArray alloc] init];
                [self.groupedSections setObject:rows forKey:cellTitle];
            }
            [self.sectionGroupTitles addObject:cellTitle];
        }
    }
    return userSettings;
}

- (NSMutableArray *)generateMultiValueOptionsArray:(NSArray *)optionTitles withValues:(NSArray *)optionValues
{
    NSMutableArray *selectionItems = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < optionTitles.count; i++) {
        
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
    RZDebugMenuVersionItem *versionItem = [[RZDebugMenuVersionItem alloc] initWithTitle:kRZVersionCellTitle version:version];
    NSArray *versionItemArray = @[versionItem];
    
    [self.groupedSections setObject:versionItemArray forKey:kRZVersionGroupTitle];
    [self.sectionGroupTitles addObject:kRZVersionGroupTitle];
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSUInteger sectionCount = self.sectionGroupTitles.count;
    if ( sectionCount == 0 ) {
        return 1;
    }
    else {
        return sectionCount;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionGroupTitles objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *cellItems = [self.groupedSections objectForKey:[self.sectionGroupTitles objectAtIndex:section]];
    return cellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *currentSection = [self.sectionGroupTitles objectAtIndex:indexPath.section];
    NSArray *currentSectionsCells = [self.groupedSections objectForKey:currentSection];
    
    UITableViewCell *cell = nil;
    RZDebugMenuItem *currentMetaDataObject = [currentSectionsCells objectAtIndex:indexPath.row];
    
    if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuMultiValueItem class]] ) {
        
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSNumber *selectionDefaultValue = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:settingsDefaultKey];
        NSInteger defaultValue = [selectionDefaultValue integerValue];
        RZDebugMenuMultiValueItem *currentMultiValueItem = (RZDebugMenuMultiValueItem *)currentMetaDataObject;
        RZMultiValueSelectionItem *currentSelection = [currentMultiValueItem.selectionItems objectAtIndex:defaultValue];
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZDisclosureReuseIdentifier forIndexPath:indexPath];
        RZDisclosureTableViewCell *disclosureCell = (RZDisclosureTableViewCell *)cell;
        disclosureCell.textLabel.text = currentMetaDataObject.title;

        disclosureCell.detailTextLabel.text = currentSelection.selectionTitle;
        cell = disclosureCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuToggleItem class]] ) {
        
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSNumber *toggleSwitchDefaultValue = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:settingsDefaultKey];
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZToggleReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.title;
        RZToggleTableViewCell *toggleCell = (RZToggleTableViewCell *)cell;

        toggleCell.applySettingsSwitch.on = [toggleSwitchDefaultValue boolValue];
        cell = toggleCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuTextFieldItem class]] ) {
        
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSString *textFieldDefaultValue = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:settingsDefaultKey];

        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZTextFieldReuseIdentifier forIndexPath:indexPath];
        RZTextFieldTableViewCell *textFieldCell = (RZTextFieldTableViewCell *)cell;
        textFieldCell.textLabel.text = currentMetaDataObject.title;

        textFieldCell.stringTextField.text = textFieldDefaultValue;
        cell = textFieldCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuSliderItem class]] ) {
        
        RZDebugMenuSliderItem *sliderMetaDataObject = (RZDebugMenuSliderItem *)currentMetaDataObject;
        NSString *settingsDefaultKey = [self getKeyIdentifierForIndexPath:indexPath];
        NSNumber *sliderDefaultValue = [RZDebugMenuSettingsInterface valueForDebugSettingsKey:settingsDefaultKey];
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZSliderReuseIdentifier forIndexPath:indexPath];
        RZSliderTableViewCell *sliderCell = (RZSliderTableViewCell *)cell;
        sliderCell.cellSlider.maximumValue = [sliderMetaDataObject.max floatValue];
        sliderCell.cellSlider.minimumValue = [sliderMetaDataObject.min floatValue];
        [sliderCell.cellSlider setValue:[sliderDefaultValue floatValue]];
        cell = sliderCell;
    }
    else if ( [currentMetaDataObject isKindOfClass:[RZDebugMenuVersionItem class]] ){
        
        cell = [self.settingsOptionsTableView dequeueReusableCellWithIdentifier:kRZVersionInfoReuseIdentifier forIndexPath:indexPath];
        cell.textLabel.text = currentMetaDataObject.title;
        cell.detailTextLabel.text = ((RZDebugMenuVersionItem *)currentMetaDataObject).versionNumber;
    }
    
    return cell;
}

#pragma mark - meta data getter methods

- (NSString *)getKeyIdentifierForIndexPath:(NSIndexPath *)indexPath
{
    id setting;
    NSInteger firstGroupExists = 1;
    
    if ( [[self.sectionGroupTitles firstObject] isEqualToString:kRZEmptyString] ) {
        firstGroupExists = 0;
    }
    
    if ( indexPath.section == 0 ) {
        // plus 1 to the index path if the 'group' item takes up the first spot on the array
        setting = [self.preferenceSpecifiers objectAtIndex:indexPath.row + firstGroupExists];
    }
    else {
        
        unsigned long numberOfPreviousCells = 0;
        for (unsigned long i = 0; i < indexPath.section; i++) {
            
            numberOfPreviousCells = numberOfPreviousCells + [self.settingsOptionsTableView numberOfRowsInSection:i];
        }
        // gets the correct index in the array of settings by taking into account the number of group items and cells before the one that is changing
        setting = [self.preferenceSpecifiers objectAtIndex:(indexPath.row + numberOfPreviousCells + indexPath.section + firstGroupExists)];
    }
    
    if ( [setting isKindOfClass:[NSDictionary class]] ) {
        return [setting objectForKey:kRZKeyItemIdentifier];
    }
    return nil;
}

- (RZDebugMenuItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( indexPath.section >= self.sectionGroupTitles.count ) {
        return nil;
    }
    
    NSString *currentSection = [self.sectionGroupTitles objectAtIndex:indexPath.section];
    NSMutableArray *cellItemsMetaData = [self.groupedSections objectForKey:currentSection];
    
    if ( cellItemsMetaData == nil ) {
        return nil;
    }
    
    NSUInteger numberOfItems = cellItemsMetaData.count;
    if ( indexPath.section >= [self.groupedSections allKeys].count || indexPath.row >= numberOfItems ) {
        return nil;
    }
    return [cellItemsMetaData objectAtIndex:indexPath.row];
}

@end
