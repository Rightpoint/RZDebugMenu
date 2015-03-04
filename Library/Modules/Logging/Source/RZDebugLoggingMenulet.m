//
//  RZDebugLoggingMenulet.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugLoggingMenulet.h"

#import "RZDebugLoggingViewController.h"

#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDFileLogger.h>

static NSString *const kRZTitleLogging = @"Logging";

static NSString *const kRZLoggingPathInCachesDirectory = @"rzdebugMenu_logs";

@implementation RZDebugLoggingMenulet

- (NSString *)title
{
    return kRZTitleLogging;
}

- (UIViewController *)viewController
{
    RZDebugLoggingViewController *loggingViewController = [[RZDebugLoggingViewController alloc] initWithNibName:nil bundle:nil];
    return loggingViewController;
}

+ (RZDebugLoggingMenulet *)sharedDebugLoggingMenulet
{
    static RZDebugLoggingMenulet *s_sharedDebugLoggingMenulet = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedDebugLoggingMenulet = [[RZDebugLoggingMenulet alloc] init];
    });

    return s_sharedDebugLoggingMenulet;
}

- (void)configureCocoaLumberjackLogging
{
    NSError *cachesDirectoryError = nil;
    NSURL *cachesDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&cachesDirectoryError];
    if ( cachesDirectoryURL ) {
        NSURL *loggingDirectoryURL = [cachesDirectoryURL URLByAppendingPathComponent:kRZLoggingPathInCachesDirectory];
        if ( loggingDirectoryURL ) {
            NSString *loggingDirectoryPath = loggingDirectoryURL.path;
            DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:loggingDirectoryPath];
            DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
            [DDLog addLogger:fileLogger];
        }
        else {
            NSLog(@"%s: Error: Can't create or find logging directory.", __PRETTY_FUNCTION__);
        }
    }
    else {
        NSLog(@"%s: Error: Can't initializes caches directory for log contents: %@", __PRETTY_FUNCTION__, cachesDirectoryError);
    }
}

@end
