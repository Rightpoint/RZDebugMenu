//
//  RZDebugMenuSettingsForm.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

@class RZDebugMenuLoadedChildPaneItem;

@protocol RZDebugMenuSettingsFormDelegate <NSObject>

- (UIViewController *)viewControllerForChildPaneItem:(RZDebugMenuLoadedChildPaneItem *)childPaneItem;

@end

@interface RZDebugMenuSettingsForm : NSObject <FXForm>

- (instancetype)initWithSettingsMenuItems:(NSArray *)settingsMenuItems NS_DESIGNATED_INITIALIZER;

@property (weak, nonatomic, readwrite) id <RZDebugMenuSettingsFormDelegate> delegate;

@end
