//
//  RZDebugMenuModalViewController.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZDebugMenuSettingsInterface.h"

@interface RZDebugMenuModalViewController : UIViewController <UITableViewDelegate>

- (id)initWithInterface:(RZDebugMenuSettingsInterface *)interface;

@end
