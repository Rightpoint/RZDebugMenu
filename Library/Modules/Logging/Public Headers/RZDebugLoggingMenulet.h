//
//  RZDebugLoggingMenulet.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenulet.h"

@interface RZDebugLoggingMenulet : NSObject <RZDebugMenulet>

+ (RZDebugLoggingMenulet *)sharedDebugLoggingMenulet;

- (void)configureCocoaLumberjackLogging;

@end
