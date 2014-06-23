//
//  RZDisclosureOptionTableViewCell.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/23/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDisclosureOptionTableViewCell.h"

@interface RZDisclosureOptionTableViewCell ()

@property (weak, nonatomic) id<RZDisclosureOptionTableViewCellDelegate>delegate;

@end

@implementation RZDisclosureOptionTableViewCell

- (id)initWithDelegate:(id<RZDisclosureOptionTableViewCellDelegate>)delegate reuseIdentifier:(NSString *)identifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if ( self ) {
        _delegate = delegate;
    }
    return self;
}

@end
