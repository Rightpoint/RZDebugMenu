//
//  RZDebugMenuShortTitles.h
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/25/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import <FXForms/FXForms.h>

// This pair of files is some hackery to FXForms to allow us to have different "long" and "short" titles in a multi-value selection item. In order to get to the FXFormField object and overwrite the the description it sends for options, we need to use a simple custom view controller and a proxy FXFormField.

@interface RZFormLongNameViewController : FXFormViewController

- (instancetype)initWithLongTitles:(NSArray *)longTitles;

@end

