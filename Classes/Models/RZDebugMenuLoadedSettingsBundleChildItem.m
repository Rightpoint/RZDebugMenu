//
//  RZDebugMenuLoadedChildPaneItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuLoadedSettingsBundleChildItem.h"

@interface RZDebugMenuLoadedSettingsBundleChildItem ()

@property (copy, nonatomic, readwrite) NSArray *settingsMenuItems;

@end

@implementation RZDebugMenuLoadedSettingsBundleChildItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName settingsMenuItems:(NSArray *)settingsMenuItems
{
    self = [super initWithTitle:title plistName:plistName];
    if ( self ) {
        self.settingsMenuItems = settingsMenuItems;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName
{
    return [self initWithTitle:title plistName:plistName settingsMenuItems:nil];
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [NSMutableDictionary dictionary];

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeDefault;

    return [mutableFieldDictionary copy];
}

- (NSArray *)fxFormsChildMenuItems
{
    return self.settingsMenuItems;
}

@end
