//
//  RZDebugMenuVersionItem.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuVersionItem : NSObject

@property(nonatomic, readonly, strong) NSString *versionNumber;

- (id)initWithVersionNumber:(NSString *)version;

@end
