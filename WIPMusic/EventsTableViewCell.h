//
//  EventsTableViewCell.h
//  WIPMusic
//
//  Created by Apple on 18/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsTableViewCell : UITableViewCell
@property (weak,nonatomic) IBOutlet UILabel* happensAtLabel;
@property (weak,nonatomic) IBOutlet UILabel* titleLabel;
@property (weak,nonatomic) IBOutlet UILabel* descritpionLabel;
@property (weak,nonatomic) IBOutlet UIImageView* eventIcon;
@property (weak,nonatomic) IBOutlet UIImageView* eventCoverPic;

@end
