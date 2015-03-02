//
//  RZDebugMenuFormViewController.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuFormViewController.h"

#import "RZDebugMenuSettingsForm.h"

static NSString *const kRZNavigationBarTitle = @"Debug Menu";

static NSString *const kRZNavigationBarDoneButtonTitle = @"Done";

@interface RZDebugMenuFormViewController ()

- (IBAction)doneButtonTapped:(id)sender;

@end

@implementation RZDebugMenuFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:kRZNavigationBarDoneButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (NSString *)title
{
    return kRZNavigationBarTitle;
}

- (void)doneButtonTapped:(id)sender
{
    [self.delegate debugMenuFormViewControllerShouldDimiss:self];
}

# pragma mark - RZDebugMenuSettingsFormDelegate

- (UIViewController *)viewControllerForChildPaneItem:(RZDebugMenuLoadedChildPaneItem *)childPaneItem
{
    NSAssert(childPaneItem != nil, @"");

    RZDebugMenuFormViewController *formViewController = [[RZDebugMenuFormViewController alloc] initWithNibName:nil bundle:nil];
    formViewController.delegate = self.delegate;

    return formViewController;
}

@end
