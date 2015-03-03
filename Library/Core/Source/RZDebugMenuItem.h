//
//  RZDebugMenuSettingsItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

@interface RZDebugMenuItem : NSObject

@property (copy, nonatomic, readonly) NSString *title;

- (instancetype)initWithTitle:(NSString *)title NS_DESIGNATED_INITIALIZER;

@property (copy, nonatomic, readonly) NSDictionary *fxFormsFieldDictionary;

@property (copy, nonatomic, readonly) NSArray *fxFormsChildMenuItems;

@property (strong, nonatomic, readonly) id value;

- (void)updateValue:(id)value;

@end
