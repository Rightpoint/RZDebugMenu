//
//  RZDebugMenuSettingItem.h
//  Pods
//
//  Created by Michael Gorbach on 2/17/15.
//
//

#import "RZDebugMenuItem.h"

@interface RZDebugMenuSettingItem : RZDebugMenuItem

- (instancetype)initWithValue:(id)value key:(NSString *)key title:(NSString *)title NS_DESIGNATED_INITIALIZER;

@property (strong, nonatomic, readonly) NSString *key;
@property (strong, nonatomic) id value;

@end
