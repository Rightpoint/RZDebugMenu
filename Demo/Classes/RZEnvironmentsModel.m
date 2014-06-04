//
//  RZEnvironmentsModel.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/4/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZEnvironmentsModel.h"

@implementation RZEnvironmentsModel

- (id)initWithTitle:(NSString *)environment andURL:(NSString *)urlPath
{
    self.environmentName = environment;
    self.environmentURL = urlPath;
    return self;
}

@end
