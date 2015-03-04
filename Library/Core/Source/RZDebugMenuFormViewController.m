//
//  RZDebugMenuFormViewController.m
//  RZDebugMenu
//
//  Created by Michael Gorbach on 2/19/15.
//  Copyright (c) 2015 Raizlabs. All rights reserved.
//

#import "RZDebugMenuFormViewController.h"

#import "RZDebugMenuItem.h"
#import "RZDebugMenuForm.h"

static NSString *const kRZNavigationBarTitle = @"Debug Menu";

static NSString *const kRZNavigationBarDoneButtonTitle = @"Done";

@interface RZDebugMenuFormViewController ()

- (IBAction)doneButtonTapped:(id)sender;

@end

@implementation RZDebugMenuFormViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        self.title = kRZNavigationBarTitle;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:kRZNavigationBarDoneButtonTitle
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(doneButtonTapped:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)doneButtonTapped:(id)sender
{
    [self.delegate debugMenuFormViewControllerShouldDimiss:self];
}

# pragma mark - RZDebugMenuSettingsFormDelegate

- (UIViewController *)viewControllerForChildPaneItem:(RZDebugMenuItem *)childPaneItem
{
    NSAssert(childPaneItem != nil, @"");

    RZDebugMenuFormViewController *formViewController = [[RZDebugMenuFormViewController alloc] initWithNibName:nil bundle:nil];
    formViewController.title = childPaneItem.title;
    formViewController.delegate = self.delegate;

    return formViewController;
}

@end
