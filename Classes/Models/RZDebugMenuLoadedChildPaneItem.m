//
//  RZDebugMenuLoadedChildPaneItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuLoadedChildPaneItem.h"

@interface RZDebugMenuLoadedChildPaneItem ()

@property (copy, nonatomic, readwrite) NSArray *settingsMenuItems;

@end

@implementation RZDebugMenuLoadedChildPaneItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName settingsMenuItems:(NSArray *)settingsMenuItems
{
    self = [super initWithTitle:title plistName:plistName];
    if ( self ) {
        self.settingsMenuItems = settingsMenuItems;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName
{
    return [self initWithTitle:title plistName:plistName settingsMenuItems:nil];
}

@end
