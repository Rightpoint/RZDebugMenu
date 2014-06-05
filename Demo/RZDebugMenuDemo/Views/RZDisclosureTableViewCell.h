//
//  RZEnvironmentsListTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZSettingsInterfaceTableViewCell.h"

@interface RZDisclosureTableViewCell : UITableViewCell

@property(atomic, strong) NSString *cellTitle;
@property(atomic, strong) NSString *currentEnvironment;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
//- (id)initWithStyle:(UITableViewCellStyle)style andTitle:(NSString *)title;
- (void)prepareForReuseWithTitle:(NSString *)title;
@end
