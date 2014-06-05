//
//  RZSettingsInterfaceTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/5/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZSettingsInterfaceTableViewCell : UITableViewCell

- (id)initEnvironmentsCellWithTitle:(NSString *)title andEnvironments:(NSArray *)environmentOptions withReuseIdentifier:(NSString *)reuseIdentifier;
- (id)initToggleCellWithTitle:(NSString *)title andValue:(BOOL)value;
- (id)initVersionCellWithVersionNumber:(NSString *)versionNumber withReuseIdentifier:(NSString *)reuseIdentifier;

@end
