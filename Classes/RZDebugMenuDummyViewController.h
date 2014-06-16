//
//  RZDebugMenuDummyViewController.h
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/12/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuDummyViewController : UIViewController

@property(strong, nonatomic, readonly) RZDebugMenuSettingsInterface *interface;

- (id)initWithInterface:(RZDebugMenuSettingsInterface *)interface;

@end
