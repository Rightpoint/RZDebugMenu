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

+ (id)setupEnvironmentsCellWithTitle:(NSString *)title andEnvironments:(NSArray *)environmentOptions
{
    id environmentsCell;
    return environmentsCell;
}

+ (id)setupToggleCellWithTitle:(NSString *)title andValue:(BOOL)value {
    id toggleCell;
    return toggleCell;
}

+ (id)setupVersionCellWithVersionNumber:(NSString *)versionNumber
{
    id versionCell;
    return versionCell;
}

@end
