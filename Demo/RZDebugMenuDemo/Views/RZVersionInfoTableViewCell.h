//
//  RZVersionInfoTableViewCell.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZSettingsInterfaceTableViewCell.h"

@interface RZVersionInfoTableViewCell : UITableViewCell

@property(nonatomic, strong) NSString *versionNumber;

//- (id)initWithStyle:(UITableViewCellStyle)style andVersionNumber:(NSString *)version;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
