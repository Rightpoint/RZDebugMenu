//
//  RZDebugMenuSettingsForm.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

@interface RZDebugMenuSettingsForm : NSObject <FXForm>

- (instancetype)initWithSettingsModels:(NSArray *)settingsModels NS_DESIGNATED_INITIALIZER;

@end
