//
//  UserDetailsViewController.m
//  WIPMusic
//
//  Created by Apple on 18/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import "UserDetailsViewController.h"
#import "UISegmentedControl+Multiline.h"
#import "BRRestaurant.h"
#import "BRUtilityClass.h"
#import "EventsTableViewCell.h"
#import "RecipeCollectionHeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "APIRequestManager.h"
#import "Constants.h"

#define KSERVERENDPOINT @"http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/restaurants.json"


@interface UserDetailsViewController ()
{
    NSDictionary* eventsDictionary;
    NSDictionary* profileDictionary;

}
@property (strong, nonatomic) UISegmentedControl* detailsSegmentControl;
@property (nonatomic, strong) NSMutableArray *restuarantsArray;
@property (strong, nonatomic) IBOutlet UICollectionView *restaurantsCollectionView;
@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
- (IBAction)backButtonTapped:(id)sender;
@end

@implementation UserDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self getRestaurantData];
    
    self.detailsSegmentControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 268, 320, 40)];
    [self.detailsSegmentControl insertSegmentWithMultilineTitle:@"4 \n Videos" atIndex:0 animated:NO];
    self.detailsSegmentControl.tintColor = [UIColor colorWithRed:42.0/255.0 green:183.0/255.0 blue:200.0/255.0 alpha:1.0];
    [self.detailsSegmentControl addTarget:self action:@selector(MySegmentControlAction:) forControlEvents: UIControlEventValueChanged];
    self.detailsSegmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.detailsSegmentControl];
    

    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.spinner.frame = CGRectMake(self.view.center.x, self.view.center.y, 100, 100);
    self.spinner.center = self.view.center;
    self.spinner.tag = 10;
    self.spinner.backgroundColor = [UIColor lightGrayColor];
    [self.spinner startAnimating];
    [self.view addSubview:self.spinner];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.profilePicImage.layer.cornerRadius = self.profilePicImage.frame.size.height/2;
    self.profilePicImage.layer.masksToBounds = YES;
    self.detailsSegmentControl.selectedSegmentIndex = 0;

    UserEventsData* eventsObj = [UserEventsData new];
    eventsObj.delegate = self;
    [eventsObj getUsersEventsDataForUserId:self.userId];

    UserMediaData* mediaObj = [UserMediaData new];
    mediaObj.delegate = self;
    [mediaObj getUsersMediaDataForUserId:self.userId];

    UserProfileData* profileObj = [UserProfileData new];
    profileObj.delegate = self;
    [profileObj getUsersProfileDataForUserId:self.userId];
}

-(void)sendUserMeidaData:(NSDictionary*)mediaData
{
    NSLog(@"Media info: %@",mediaData);
}

-(void)sendUserEventsData:(NSDictionary*)eventsData
{
    NSLog(@"Events info: %@",eventsData);

    eventsDictionary = eventsData;
    [self.eventsTableView reloadData];
    
    NSDictionary* paginationDict = eventsDictionary[@"pagination"];
    
    [self.detailsSegmentControl insertSegmentWithMultilineTitle:[NSString stringWithFormat:@"%ld \n Events",[paginationDict[@"count"] integerValue]] atIndex:1 animated:NO];

}

-(void)sendUserProfileData:(NSDictionary*)profileData
{
    NSLog(@"User profile :%@",profileData);
    
    profileDictionary = profileData[@"data"];
    
    NSURL *avatarUrl = [NSURL URLWithString:profileDictionary[@"avatar_url"]];
    
    [self.profilePicImage sd_setImageWithURL:avatarUrl
                     placeholderImage:[UIImage imageNamed:@"Default_Friends"]
                              options:SDWebImageRefreshCached];
    
    NSURL *coverUrl = [NSURL URLWithString:profileDictionary[@"cover_url"]];
    
    [self.coverPicImage sd_setImageWithURL:coverUrl
                            placeholderImage:[UIImage imageNamed:@"Default_Friends"]
                                     options:SDWebImageRefreshCached];
    
    self.professionLabel.text = profileDictionary[@"role"];
    self.nameLabel.text = profileDictionary[@"display_name"];
    self.userDescription.text = profileDictionary[@"biography"];
    
    NSDictionary* counterDict = profileDictionary[@"counters"];
    self.followersCountLabel.text = [NSString stringWithFormat:@"%ld",[counterDict[@"followers"] integerValue]];
    self.followingCountLabel.text = [NSString stringWithFormat:@"%ld",[profileDictionary[@"followed_by_self"] integerValue]];
    
    [self.spinner stopAnimating];
}

- (IBAction)backButtonTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)MySegmentControlAction:(UISegmentedControl *)segment
{
    if(segment.selectedSegmentIndex == 0)
    {
        // code for the first button
        
        self.eventsTableView.hidden = YES;
        self.restaurantsCollectionView.hidden = NO;
        [self.restaurantsCollectionView reloadData];
        [self.view bringSubviewToFront:self.restaurantsCollectionView];
    }
    else
    {
        self.eventsTableView.hidden = NO;
        self.restaurantsCollectionView.hidden = YES;
        [self.eventsTableView reloadData];
        [self.view bringSubviewToFront:self.eventsTableView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getRestaurantData
{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:KSERVERENDPOINT]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error){
                
                self.restuarantsArray = [NSMutableArray new];
                
                @autoreleasepool
                {
                    
                    NSDictionary* foodDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options: NSJSONReadingAllowFragments
                                                                                     error:&error];
                    NSArray* tempRestaurantsArray = foodDictionary[@"restaurants"];
                    
                    for(int i = 0; i < tempRestaurantsArray.count; i++)
                    {
                        if (tempRestaurantsArray[i] != (id)[NSNull null])
                        {
                            BRRestaurant *restaurantObj = [[BRRestaurant alloc] initWithRestaurantsObject:tempRestaurantsArray[i]];
                            [self.restuarantsArray addObject:restaurantObj];
                        }
                    }
                    
                    //UI should always be chnaged on main thread
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //update UI in main thread.
                    [self.restaurantsCollectionView reloadData];
                    
                });
                
            }] resume];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self.restaurantsCollectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        RecipeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        if(indexPath.section == 0)
        {
            headerView.headerLabel.text = @"Best videos";
            
        }else if(indexPath.section == 1)
        {
            headerView.headerLabel.text = @"All videos";
        }
        
        reusableview = headerView;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width/3, 140);

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 3;
 
    }
    else
    {
        return 4;
  
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"restaurantCell" forIndexPath:indexPath];
    UIImageView *restImageView = (UIImageView *)[cell.contentView viewWithTag:1];
    UILabel *restName = (UILabel *)[cell.contentView viewWithTag:2];
    UILabel *categoryType = (UILabel *)[cell.contentView viewWithTag:3];
    categoryType.font = [UIFont fontWithName:@"AvenirNext-Bold" size:[UIScreen mainScreen].bounds.size.height * 0.02112676056];
    BRRestaurant *restaurantObj = self.restuarantsArray[indexPath.row];
    
    restName.text = restaurantObj.name;
    categoryType.text = restaurantObj.category;
    
    NSURL *url = [NSURL URLWithString:restaurantObj.backgroundImageURL];
    
    [restImageView sd_setImageWithURL:url
                         placeholderImage:[UIImage imageNamed:@"Default_Friends"]
                                  options:SDWebImageRefreshCached];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma  mark - Tableview Delegate & Data Source Methods

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [UIView new];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary* paginationDict = eventsDictionary[@"pagination"];
    return [paginationDict[@"count"] integerValue];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"EventsTableViewCell";
    
    EventsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventsTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSArray* dataArray = eventsDictionary[@"data"];
    NSDictionary* eventObj = dataArray[indexPath.row];
    cell.happensAtLabel.text = eventObj[@"happens_at"];
    cell.titleLabel.text = eventObj[@"title"];
    cell.descritpionLabel.text = eventObj[@"description"];
    
    NSURL *avatarUrl = [NSURL URLWithString:profileDictionary[@"avatar_url"]];
    
    [cell.eventIcon sd_setImageWithURL:avatarUrl
                            placeholderImage:[UIImage imageNamed:@"Default_Friends"]
                                     options:SDWebImageRefreshCached];
    
    NSURL *coverUrl = [NSURL URLWithString:profileDictionary[@"cover_url"]];
    
    [cell.eventCoverPic sd_setImageWithURL:coverUrl
                          placeholderImage:[UIImage imageNamed:@"Default_Friends"]
                                   options:SDWebImageRefreshCached];

    return cell;
    
}

- (IBAction)followButtonTapped:(id)sender
{
    
}

- (IBAction)readMoreButtonTapped:(id)sender
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.spinner stopAnimating];
}

@end


///users/:id/events

//    NSMutableDictionary* dict = [NSMutableDictionary new];
//    [dict setObject:@"Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjI0ODQ1ODMxMDYsImEzcy5hcHBfaWQiOjgsImEzcy5vd25lcl90eXBlIjoiVXNlciIsImEzcy5vd25lcl9pZCI6IjQifQ.32kfbtLK7yCe5Q9rDdmGpWBXtJDhXCOaIz_K5DPdeEA" forKey:@"access_token"];
//
//    NSLog(@"URL :%@",[NSString stringWithFormat:@"%@%@",SERVER_ENDPOINT,@"users/1/events"]);
//
//    [APIRequestManager PostWithUrl:[NSString stringWithFormat:@"%@%@",SERVER_ENDPOINT,@"users/1/events"] Parameters:dict success:^(id json) {
//
//        NSLog(@"Json: %@",json);
//
//    } failure:^(NSError *error) {
//
//        NSLog(@"Error Description: %@",error.description);
//    }];

//    NSString *getString = [NSString stringWithFormat:@"parameter=%@",yourvalue];
//    NSData *getData = [getString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];

//Unified API endpoint for sending mail

//- (void)tempMethod
//{
//    NSString *getString = [NSString stringWithFormat:@"parameter=%@",yourvalue];
//    NSData *getData = [getString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//
//    NSString *getLength = [NSString stringWithFormat:@"%d", [getData length]];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//
//    [request setURL:[NSURL URLWithString:@"https:yoururl"]];
//
//    [request setHTTPMethod:@"GET"];
//
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json, text/plain, */*" forHTTPHeaderField:@"Accept"];
//
//    [request setHTTPBody:getData];
//
//    NSURLConnection* urlConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//
//    NSAssert(urlConnection != nil, @"Failure to create URL connection.");
//
//    // show in the status bar that network activity is starting
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}

//- (void)getUsersData
//{
//
////    NSString *getString = [NSString stringWithFormat:@"id=%d",1];
////    NSData *getData = [getString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"wip-api.westeurope.cloudapp.azure.com/users/1/events"]];
//    [request setHTTPMethod:@"GET"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//
//    // Access token required for request header
//    NSString *authorization = [NSString stringWithFormat:@"Bearer %@", @"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjI0ODQ1ODMxMDYsImEzcy5hcHBfaWQiOjgsImEzcy5vd25lcl90eXBlIjoiVXNlciIsImEzcy5vd25lcl9pZCI6IjQifQ.32kfbtLK7yCe5Q9rDdmGpWBXtJDhXCOaIz_K5DPdeEA"];
//    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
//    [request setValue:@"50,4" forHTTPHeaderField:@"From-Location"];
//
////    [request setHTTPBody:getData];
//
//    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//
//    if(conn) {
//        NSLog(@"Connection Successful");
//    } else {
//        NSLog(@"Connection could not be made");
//    }
//
//    [conn start];
//
//}
//
//#pragma mark NSUrl Connection Delagatre Methods
//
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    NSLog(@"Response is:%@",response);
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    NSLog(@"Error is:%@",error);
//
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    NSLog(@"Response is:%@",data);
//}

