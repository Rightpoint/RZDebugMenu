//
//  RZDebugMenuModalViewController.m
//  RZDebugMenuDemo
//
//  Created by Clayton Rieck on 6/2/14.
//  Copyright (c) 2014 Raizlabs. All rights reserved.
//

#import "RZDebugMenuModalViewController.h"
#import "RZDebugMenuRootViewController.h"
#import "RZDebugMenu.h"

@interface RZDebugMenuModalViewController ()

@end


@implementation RZDebugMenuModalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Env Settings";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat width = screen.size.width;
    CGFloat height = screen.size.height;
    
    UITableView *options = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height)
                                                        style:UITableViewStylePlain];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(closeView)];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(addEnvironment)];
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = addButton;
    [[self view] addSubview:options];
    options.delegate = self;
    options.dataSource = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - nav bar buttons methods

- (void)closeView {
    // TODO: save plist in completion
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addEnvironment {
    // TODO: call methods to edit plist in settings bundle
}

#pragma mark - table view delegate methods

- (NSInteger)numberOfSectionsInTableView: (UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger *)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"Environment";
        cell.detailTextLabel.text = @"Placeholder";
    }
    else if (indexPath.row == 1) {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UISwitch *applySettingsSwitch = [[UISwitch alloc] init];
        cell.accessoryView = [[UIView alloc] initWithFrame:applySettingsSwitch.frame];
        [cell.accessoryView addSubview:applySettingsSwitch];
        cell.textLabel.text = @"Apply Changes on Reset";
    }
    else {
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"Version";
        cell.detailTextLabel.text = @"0.0.1";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    // TODO: Present view with list of environments they have
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
