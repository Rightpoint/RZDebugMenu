//
//  RZSettingsObserverManagerTests.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 7/22/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZDebugMenuSettingsObserverManager.h"

@interface RZSettingsObserverManagerTests : XCTestCase

@end

@implementation RZSettingsObserverManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitializationOfSharedInstance
{
    XCTAssertNotNil([RZDebugMenuSettingsObserverManager sharedInstance], @"Should have created a shared instance");
}

- (void)testSingletonReturnsSameType
{
    id s1 = [RZDebugMenuSettingsObserverManager sharedInstance];
    XCTAssertTrue([s1 isKindOfClass:[RZDebugMenuSettingsObserverManager class]], @"Initialization should return same instance type");
}

- (void)testRemovalOfObserverForKey
{
    
}

@end
