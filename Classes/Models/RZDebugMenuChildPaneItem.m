//
//  RZDebugChildPaneMenuItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuChildPaneItem.h"

@interface RZDebugMenuChildPaneItem ()

@property (copy, nonatomic, readwrite) NSString *plistName;

@end

@implementation RZDebugMenuChildPaneItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName
{
    self = [super initWithTitle:title];
    if ( self ) {
        self.plistName = plistName;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title plistName:nil];
}

@end
