//
//  RZDebugMenuMultiValueItem.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuMultiValueItem : RZDebugMenuSettingsInterface

@property(nonatomic, strong) NSString *disclosureTableViewCellTitle;
@property(nonatomic, strong) NSString *disclosureTableViewCellDefaultValue;
@property(nonatomic, strong) NSArray *selectionTitles;
@property(nonatomic, strong) NSArray *selectionValues;

- (id)initWithTitle:(NSString *)title defaultValue:(NSString *)value andOptions:(NSArray *)options withValues:(NSArray *)optionValues;

@end
