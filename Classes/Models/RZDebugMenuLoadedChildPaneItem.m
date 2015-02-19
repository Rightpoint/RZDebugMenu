//
//  RZDebugMenuLoadedChildPaneItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuLoadedChildPaneItem.h"

@interface RZDebugMenuLoadedChildPaneItem ()

@property (copy, nonatomic, readwrite) NSArray *settingsModels;

@end

@implementation RZDebugMenuLoadedChildPaneItem

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName settingsModels:(NSArray *)settingsModels
{
    self = [super initWithTitle:title plistName:plistName];
    if ( self ) {
        self.settingsModels = settingsModels;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title plistName:(NSString *)plistName
{
    return [self initWithTitle:title plistName:plistName settingsModels:nil];
}

@end
