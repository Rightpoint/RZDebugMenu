//
//  RZDebugMenuSettingsDataSource.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/15/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"

@interface RZDebugMenuSettingsDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *settingsOptionsTableView;
@property (strong, nonatomic, readonly) NSMutableArray *settingsKeys;

- (id)initWithDictionary:(NSDictionary *)plistData;
- (RZDebugMenuSettingsItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath;

@end
