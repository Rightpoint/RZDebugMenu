//
//  RZDebugMenuObserver.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/1/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZDebugMenuObserver : NSObject

@property (weak, nonatomic) id observer;
@property (assign, nonatomic) SEL aSelector;

- (id)initWithObserver:(id)observer selector:(SEL)aSelector;

@end
