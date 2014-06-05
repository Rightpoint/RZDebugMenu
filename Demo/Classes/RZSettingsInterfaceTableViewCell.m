//
//  RZSettingsInterfaceTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/5/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSettingsInterfaceTableViewCell.h"
#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"

static NSString * const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString * const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";

@implementation RZSettingsInterfaceTableViewCell

- (id)initEnvironmentsCellWithTitle:(NSString *)title andEnvironments:(NSArray *)environmentOptions withReuseIdentifier:(NSString *)reuseIdentifier
{
    id environmentsCell;
    return environmentsCell;
}

- (id)initToggleCellWithTitle:(NSString *)title andValue:(BOOL)value
{
    id toggleCell = [[RZToggleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 cellTitle:title andSwitchValue:value];
    return toggleCell;
}

- (id)initVersionCellWithVersionNumber:(NSString *)versionNumber withReuseIdentifier:(NSString *)reuseIdentifier
{
    id versionCell;
    return versionCell;
}

@end
