//
//  RZDebugMenuSettingsDataSource.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/15/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuSettingsDataSource : NSObject <UITableViewDataSource>

@property (weak, nonatomic) UITableView *settingsOptionsTableView;
@property (strong, nonatomic, readonly) NSMutableArray *settingsKeys;

- (id)initWithDictionary:(NSDictionary *)plistData;
- (RZDebugMenuItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath;

@end
