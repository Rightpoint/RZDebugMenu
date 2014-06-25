//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"
#import "RZMultiValueSelectionItem.h"
#import "RZToggleTableViewCell.h"

@interface RZDebugMenuSettingsInterface : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *settingsOptionsTableView;

- (id)initWithDictionary:(NSDictionary *)plistData;
- (RZDebugMenuSettingsItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)setValue:(id)value forDebugSettingsKey:(NSString *)key;

@end
