//
//  RZDebugMenuForm.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

@class RZDebugMenuItem;

@protocol RZDebugMenuSettingsFormDelegate <NSObject>

- (UIViewController *)viewControllerForChildPaneItem:(RZDebugMenuItem *)childPaneItem;

@end

@interface RZDebugMenuForm : NSObject <FXForm>

- (instancetype)initWithMenuItems:(NSArray *)meuItems NS_DESIGNATED_INITIALIZER;

@property (weak, nonatomic, readwrite) id <RZDebugMenuSettingsFormDelegate> delegate;

@end
