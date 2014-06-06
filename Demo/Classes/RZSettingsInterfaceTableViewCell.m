//
//  RZSettingsInterfaceTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/5/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZSettingsInterfaceTableViewCell.h"
#import "RZDisclosureTableViewCell.h"
#import "RZToggleTableViewCell.h"
#import "RZVersionInfoTableViewCell.h"

@implementation RZSettingsInterfaceTableViewCell

- (void)setCellTitleAs:(NSString *)title
{
    self.cellTitle = title;
    NSLog(@"Title %@:", self.cellTitle);
}

@end
