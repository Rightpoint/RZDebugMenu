//
//  RZDebugMenuObserver.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/1/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuObserver : NSObject

@property (weak, nonatomic, readonly) id target;
@property (assign, nonatomic, readonly) SEL aSelector;

- (id)initWithObserver:(id)observer selector:(SEL)aSelector;

@end
