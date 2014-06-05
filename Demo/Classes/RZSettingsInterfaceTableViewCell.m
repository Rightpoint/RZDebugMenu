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

static NSString * const kRZMultiValueSpecifier = @"PSMultiValueSpecifier";
static NSString * const kRZToggleSwitchSpecifier = @"PSToggleSwitchSpecifier";

@implementation RZSettingsInterfaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(NSString *)cellType
{
    id resultingCell;
    NSLog(@"in init");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"in self if");
        if ( [cellType isEqualToString:kRZMultiValueSpecifier] ) {
            NSLog(@"init disclosure cell");
            resultingCell = [[RZDisclosureTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        }
    }
    return resultingCell;
}

+ (id)setupToggleCellWithTitle:(NSString *)title andValue:(BOOL)value {
    id toggleCell = [[RZToggleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"toggle"];
    return toggleCell;
}

@end
