//
//  RZDebugMenuViewControllerItem.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 3/4/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuViewControllerItem.h"

#import "RZDebugMenu.h"

@interface RZDebugMenuViewControllerItem ()

@property (strong, nonatomic, readwrite) UIViewController *viewController;

@end

@implementation RZDebugMenuViewControllerItem

- (instancetype)initWithTitle:(NSString *)title viewController:(UIViewController *)viewController
{
    self = [super initWithTitle:title];
    if ( self ) {
        self.viewController = viewController;
    }

    return self;
}

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title viewController:nil];
}

- (NSDictionary *)fxFormsFieldDictionary
{
    NSMutableDictionary *mutableFieldDictionary = [[super fxFormsFieldDictionary] mutableCopy];

    mutableFieldDictionary[FXFormFieldType] = FXFormFieldTypeDefault;
    mutableFieldDictionary[FXFormFieldDefaultValue] = self.viewController;
    mutableFieldDictionary[FXFormFieldClass] = [UIViewController class];

    return [mutableFieldDictionary copy];
}

@end
