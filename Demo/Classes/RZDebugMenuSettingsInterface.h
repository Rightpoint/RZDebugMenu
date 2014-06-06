//
//  RZDebugMenuSettingsInterface.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuSettingsInterface : NSObject

@property(nonatomic, strong) NSMutableArray *settingsCellItems;

- (id)initWithDictionary:(NSDictionary *)plistData;

@end