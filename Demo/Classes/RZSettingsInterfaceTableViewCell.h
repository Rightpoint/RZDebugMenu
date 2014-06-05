//
//  RZSettingsInterfaceTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/5/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZSettingsInterfaceTableViewCell : UITableViewCell

- (id)setupEnvironmentsCellWithTitle:(NSString *)title andEnvironments:(NSArray *)environmentOptions withReuseIdentifier:(NSString *)reuseIdentifier;
- (id)setupToggleCellWithTitle:(NSString *)title andValue:(BOOL)value;
- (id)setupVersionCellWithVersionNumber:(NSString *)versionNumber withReuseIdentifier:(NSString *)reuseIdentifier;

@end
