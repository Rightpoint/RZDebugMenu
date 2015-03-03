//
//  RZDebugMenuFormViewController.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

#import "RZDebugMenuForm.h"

@class RZDebugMenuFormViewController;

@protocol RZDebugMenuFormViewControllerDelegate <NSObject>

- (void)debugMenuFormViewControllerShouldDimiss:(RZDebugMenuFormViewController *)debugMenuFormViewController;

@end

@interface RZDebugMenuFormViewController : FXFormViewController <RZDebugMenuSettingsFormDelegate>

@property (weak, nonatomic, readwrite) id <RZDebugMenuFormViewControllerDelegate> delegate;

@end
