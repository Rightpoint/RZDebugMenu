//
//  RZLoggingMacros.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#ifndef RZDebugMenuDemo_RZLoggingMacros_h
#define RZDebugMenuDemo_RZLoggingMacros_h

#if DEBUG
#define RZDebugMenuLogDebug_log( s, ... ) NSLog((@"[RZDebugMenu]: DEBUG --  (s)"), ##__VA_ARGS__)
#endif

#define RZDebugMenuErrorLog( s, ... ) NSLog((@"[RZDebugMenu]: ERROR -- (s)"). ##__VA_ARGS__)

#endif
