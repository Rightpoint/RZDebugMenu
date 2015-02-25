//
//  RZDebugMenuToggleItem.h
//  RZDebugMenu
//
//  Created by Clayton Rieck on 6/6/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuSettingItem.h"

@interface RZDebugMenuToggleItem : RZDebugMenuSettingItem

- (id)initWithValue:(id)value
                key:(NSString *)key
              title:(NSString *)title
          trueValue:(id)trueValue
         falseValue:(id)falseValue
NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) id trueValue;
@property (strong, nonatomic, readonly) id falseValue;

@end
