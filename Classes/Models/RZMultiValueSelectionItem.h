//
//  RZMultiValueSelectionItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/10/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RZMultiValueSelectionItem;
@protocol RZMultiValueSelectionItemDelegate <NSObject>

- (void)didMakeNewSelection:(NSIndexPath *)indexPath;

@end

@interface RZMultiValueSelectionItem : NSObject

@property (weak, nonatomic) id<RZMultiValueSelectionItemDelegate>delegate;
@property (strong, nonatomic, readonly) NSString *selectionTitle;
@property (strong, nonatomic, readonly) NSNumber *selectionValue;

- (id)initWithTitle:(NSString *)title defaultValue:(NSNumber *)value;

@end
