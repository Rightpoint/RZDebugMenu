//
//  RZDebugMenuMultiValueSelectionItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuMultiValueSelectionItem : RZDebugMenuItem

@property (strong, nonatomic, readonly) id value;

@property (copy, nonatomic, readonly) NSString *longTitle;
@property (copy, nonatomic, readonly) NSString *shortTitle;

- (instancetype)initWithLongTitle:(NSString *)longTitle shortTitle:(NSString *)shortTitle value:(id)value NS_DESIGNATED_INITIALIZER;

@end
