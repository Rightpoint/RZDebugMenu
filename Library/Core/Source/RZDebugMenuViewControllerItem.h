//
//  RZDebugMenuViewControllerItem.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuViewControllerItem : RZDebugMenuItem

- (instancetype)initWithTitle:(NSString *)title viewController:(UIViewController *)viewController NS_DESIGNATED_INITIALIZER;

@end
