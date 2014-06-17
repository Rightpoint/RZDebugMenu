//
//  RZMultiValueSelectionItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RZMultiValueSelectionItem : NSObject

@property (strong, nonatomic, readonly) NSString *selectionTitle;
@property (strong, nonatomic, readonly) NSNumber *selectionValue;

- (id)initWithTitle:(NSString *)title andValue:(NSNumber *)value;

@end