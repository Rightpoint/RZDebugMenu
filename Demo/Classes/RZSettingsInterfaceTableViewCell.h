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

- (void)setCellTitleAs:(NSString *)title;

@end
