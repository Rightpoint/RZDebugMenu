//
//  RZSettingsInterfaceTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/5/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZSettingsInterfaceTableViewCell : UITableViewCell

@property(nonatomic, strong) NSString *cellTitle;


- (id)initEnvironmentsCellWithTitle:(NSString *)title;
- (id)initToggleCellWithTitle:(NSString *)title andValue:(BOOL)value;
- (id)initVersionCellWithVersionNumber:(NSString *)versionNumber;

@end
