//
//  RZDebugMenuToggleItem.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuToggleItem : RZDebugMenuSettingsInterface

@property(nonatomic, strong) NSString *toggleCellTitle;
@property(assign) BOOL toggleCellDefaultValue;

- (id)initWithTitle:(NSString *)title andValue:(BOOL)value;

@end
