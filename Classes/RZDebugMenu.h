//
//  RZDebugMenu.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/11/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZDebugMenuClearViewController.h"

@interface RZDebugMenu : NSObject <UIGestureRecognizerDelegate>

+ (void)enableWithSettingsPlist:(NSString *)fileName;

@end
