//
//  LandingPageViewController.m
//  WIPMusic
//
//  Created by Apple on 18/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import "LandingPageViewController.h"
#import "UserDetailsViewController.h"

@interface LandingPageViewController ()
- (IBAction)userOneButtonTapped:(id)sender;
- (IBAction)userTwoButtonTapped:(id)sender;
@end

@implementation LandingPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)userOneButtonTapped:(id)sender
{
    UserDetailsViewController* userDetailsView   = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
    userDetailsView.userId = @"1";
    [self.navigationController pushViewController:userDetailsView animated:YES];
}

- (IBAction)userTwoButtonTapped:(id)sender
{
    UserDetailsViewController* userDetailsView   = [self.storyboard instantiateViewControllerWithIdentifier:@"UserDetailsViewController"];
    userDetailsView.userId = @"2";
    [self.navigationController pushViewController:userDetailsView animated:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
