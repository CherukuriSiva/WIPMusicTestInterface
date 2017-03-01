//
//  UserDetailsViewController.h
//  WIPMusic
//
//  Created by Apple on 18/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEventsData.h"
#import "UserProfileData.h"
#import "UserMediaData.h"

@interface UserDetailsViewController : UIViewController<UserEventsDelegate,UserProfileDelegate,UserMediaDelegate>
@property (strong, nonatomic) NSString* userId;
@property (weak, nonatomic) IBOutlet UIImageView* profilePicImage;
@property (weak, nonatomic) IBOutlet UIImageView* coverPicImage;
@property (weak, nonatomic) IBOutlet UILabel* nameLabel;
@property (weak, nonatomic) IBOutlet UILabel* professionLabel;
@property (weak, nonatomic) IBOutlet UILabel* followersLabel;
@property (weak, nonatomic) IBOutlet UILabel* followersCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* followingLabel;
@property (weak, nonatomic) IBOutlet UILabel* followingCountLabel;
@property (weak, nonatomic) IBOutlet UIButton* followButton;
@property (weak, nonatomic) IBOutlet UITextView* userDescription;
@property (weak, nonatomic) IBOutlet UIButton* readMoreButton;

- (IBAction)followButtonTapped:(id)sender;
- (IBAction)readMoreButtonTapped:(id)sender;

@end
