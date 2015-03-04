//
//  RZDebugMenulet.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/3/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

@protocol RZDebugMenulet < NSObject >

@property (strong, nonatomic, readonly) NSString *title;

@optional
@property (strong, nonatomic, readonly) UIViewController *viewController;
@property (copy, nonatomic, readonly) NSArray *menuItems;

@end
