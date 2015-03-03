//
//  RZDebugMenuShortTitles.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/25/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuShortTitles.h"

#import <FXForms/FXForms.h>

@interface RZFormLongNameProxyField : NSObject

- (instancetype)initWithFormField:(FXFormField *)formField longTitles:(NSArray *)longTitles;

@end

@interface RZFormLongNameViewController ()

@property (copy, nonatomic, readwrite) NSArray *longTitles;

@end

@implementation RZFormLongNameViewController

- (instancetype)initWithLongTitles:(NSArray *)longTitles
{
    self = [super initWithNibName:nil bundle:nil];
    if ( self ) {
        self.longTitles = longTitles;
    }

    return self;
}

- (void)setField:(FXFormField *)field
{
    RZFormLongNameProxyField *proxyField = [[RZFormLongNameProxyField alloc] initWithFormField:field longTitles:self.longTitles];
    [super setField:(FXFormField *)proxyField];
}

@end

@interface RZFormLongNameProxyField ()

@property (strong, nonatomic, readwrite) FXFormField *formField;
@property (copy, nonatomic, readwrite) NSArray *longTitles;

@end

@implementation RZFormLongNameProxyField

- (instancetype)initWithFormField:(FXFormField *)formField longTitles:(NSArray *)longTitles
{
    self = [super init];
    if ( self ) {
        self.formField = formField;
        self.longTitles = longTitles;
    }

    return self;
}

- (NSString *)optionDescriptionAtIndex:(NSUInteger)index
{
    return self.longTitles[index];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return self.formField;
}

@end
