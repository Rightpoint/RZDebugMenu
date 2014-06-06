//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsInterface : NSObject

#pragma mark - cell titles
@property(nonatomic, strong) NSString *disclosureTableViewCellTitle;
@property(nonatomic, strong) NSString *toggleTableViewCellTitle;

#pragma mark - cell default values
@property(nonatomic, strong) NSString *disclosureTableViewCellDefaultValue;
@property(nonatomic, strong) NSString *toggleTableViewCellDefaultValue;

#pragma mark - environments
@property(nonatomic, strong) NSArray *environmentNames;
@property(nonatomic, strong) NSArray *environmentValues;

- (id)initWithDictionary:(NSDictionary *)plistData;

@end
