//
//  RZDebugMenuForm.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/18/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuForm.h"

#import "RZDebugMenuItem.h"
#import "RZDebugMenuGroupItem.h"
#import "RZDebugMenuFormViewController.h"

#import "RZDebugMenuShortTitles.h"

@interface RZDebugMenuForm ()

@property (strong, nonatomic, readwrite) NSArray *menuItems;

@property (strong, nonatomic, readwrite) NSArray *cachedFields;

@property (strong, nonatomic, readwrite) NSDictionary *menuItemsByKey;

@end

@implementation RZDebugMenuForm

- (instancetype)initWithMenuItems:(NSArray *)menuItems
{
    self = [super init];
    if ( self ) {
        self.menuItems = menuItems;
    }

    return self;
}

+ (NSArray *)menuItemsByFlatteningGroupsFromMenuItems:(NSArray *)menuItems
{
    NSMutableArray *mutableSettingsMenuItems = [NSMutableArray array];

    for ( RZDebugMenuItem *menuItem in menuItems ) {
        [mutableSettingsMenuItems addObject:menuItem];

        if ( [menuItem isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            NSArray *children = ((RZDebugMenuGroupItem *)menuItem).children;
            if ( children.count > 0 ) {
                [mutableSettingsMenuItems addObjectsFromArray:children];
            }
        }
    }

    return [mutableSettingsMenuItems copy];
}

- (NSArray *)uncachedFields
{
    NSArray *flattenedMenuItems = [[self class] menuItemsByFlatteningGroupsFromMenuItems:self.menuItems];

    NSMutableArray *mutableFields = nil;
    NSMutableDictionary *mutableMenuItemsByKey = nil;

    RZDebugMenuGroupItem *groupToStart = nil;

    for ( RZDebugMenuItem *item in flattenedMenuItems ) {
        NSDictionary *fieldDictionary = item.fxFormsFieldDictionary;

        NSArray *childMenuItems = item.fxFormsChildMenuItems;
        if ( childMenuItems.count > 0 ) {
            NSMutableDictionary *mutableFieldDictionary = [fieldDictionary mutableCopy];

            RZDebugMenuForm *childSettingsForm = [[RZDebugMenuForm alloc] initWithMenuItems:childMenuItems];
            childSettingsForm.delegate = self.delegate;

            mutableFieldDictionary[FXFormFieldDefaultValue] = childSettingsForm;

            mutableFieldDictionary[FXFormFieldClass] = [RZDebugMenuForm class];

            UIViewController *formViewController = [self.delegate viewControllerForChildPaneItem:item];
            NSAssert(formViewController != nil, @"");

            mutableFieldDictionary[FXFormFieldViewController] = formViewController;

            fieldDictionary = [mutableFieldDictionary copy];
        }

        if ( groupToStart ) {
            NSAssert([item isKindOfClass:[RZDebugMenuGroupItem class]] == NO, @"Nested groups aren't allowed!");

            NSMutableDictionary *mutableFieldDictionary = [fieldDictionary mutableCopy];

            mutableFieldDictionary[FXFormFieldHeader] = groupToStart.title;

            groupToStart = nil;

            fieldDictionary = [mutableFieldDictionary copy];
        }

        if ( [item isKindOfClass:[RZDebugMenuGroupItem class]] ) {
            groupToStart = (RZDebugMenuGroupItem *)item;
        }

        NSString *formFieldType = fieldDictionary[FXFormFieldType];

        if ( formFieldType.length > 0 ) {
            if ( mutableFields == nil ) {
                mutableFields = [NSMutableArray array];
            }

            [mutableFields addObject:fieldDictionary];
        }

        NSString *key = fieldDictionary[FXFormFieldKey];
        if ( key.length > 0 ) {
            if ( mutableMenuItemsByKey == nil ) {
                mutableMenuItemsByKey = [NSMutableDictionary dictionary];
            }

            mutableMenuItemsByKey[key] = item;
        }
    }

    self.menuItemsByKey = [mutableMenuItemsByKey copy];

    return [mutableFields copy];
}

- (NSArray *)fields
{
    NSArray *cachedFields = self.cachedFields;

    if ( cachedFields == nil ) {
        cachedFields = [self uncachedFields];
        self.cachedFields = cachedFields;
    }

    return cachedFields;
}

- (id)valueForKey:(NSString *)key
{
    id value = nil;

    RZDebugMenuItem *menuItem = [self menuItemsByKey][key];
    if ( menuItem ) {
        value = menuItem.value;
    }
    else {
        value = [super valueForKey:key];
    }

    return value;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    RZDebugMenuItem *menuItem = [self menuItemsByKey][key];
    if ( menuItem ) {
        [menuItem updateValue:value];
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
