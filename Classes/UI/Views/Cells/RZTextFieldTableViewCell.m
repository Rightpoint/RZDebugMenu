//
//  RZTextFieldTableViewCell.m
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/30/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZTextFieldTableViewCell.h"

@implementation RZTextFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if ( self ) {
        _stringLabel = [[UILabel alloc] init];
        self.accessoryView = [[UIView alloc] initWithFrame:_stringLabel.frame];
    }
    
    return self;
}

@end
