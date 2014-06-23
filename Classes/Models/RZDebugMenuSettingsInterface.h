//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsItem.h"
#import "RZToggleTableViewCell.h"
#import "RZMultiValueSelectionItem.h"

@interface RZDebugMenuSettingsInterface : NSObject
<RZMultiValueSelectionItemDelegate,
RZToggleTableViewCellDelegate,
UITableViewDataSource>

@property (weak, nonatomic) UITableView *settingsOptionsTableView;

- (id)initWithDictionary:(NSDictionary *)plistData;
- (RZDebugMenuSettingsItem *)settingsItemAtIndexPath:(NSIndexPath *)indexPath;

@end
