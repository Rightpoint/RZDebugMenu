//
//  RZDebugMenuObserver.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/1/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

@interface RZDebugMenuObserver : NSObject

@property (weak, nonatomic, readonly) id target;
@property (assign, nonatomic, readonly) SEL selector;

- (id)initWithObserver:(id)observer selector:(SEL)selector NS_DESIGNATED_INITIALIZER;

@end
