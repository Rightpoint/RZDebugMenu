//
//  RZDebugLogMenuDefines.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 7/3/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#ifndef RZDebugMenuDemo_RZDebugLogMenuDefines_h
#define RZDebugMenuDemo_RZDebugLogMenuDefines_h

#if DEBUG
#define RZDebugMenuLogDebug( s, ... ) NSLog((@"[RZDebugMenu]: DEBUG --  s"), ##__VA_ARGS__)
#else
#define RZDebugMenuLogDebug( s, ... )
#endif

#define RZDebugMenuLogError( s, ... ) NSLog((@"[RZDebugMenu]: ERROR -- s"). ##__VA_ARGS__)

#endif
