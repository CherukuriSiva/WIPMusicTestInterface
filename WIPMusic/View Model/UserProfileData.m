//
//  UserProfileData.m
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import "UserProfileData.h"
#import "Constants.h"

@implementation UserProfileData

- (void)getUsersProfileDataForUserId:(NSString*)userId
{
    
    NSMutableArray* profileArray = [NSMutableArray new];
    [profileArray addObject:@"biography"];
    [profileArray addObject:@"website"];
    [profileArray addObject:@"cover_url"];

        NSMutableDictionary* profileParams = [NSMutableDictionary new];
        NSMutableArray* countersArray = [NSMutableArray new];
        [countersArray addObject:@"medias"];
        [countersArray addObject:@"events"];
        [countersArray addObject:@"followers"];
        [countersArray addObject:@"subscriptions"];
        [profileParams setObject:countersArray forKey:@"counters"];
    
    [profileArray addObject:profileParams];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profileArray options:0 error:nil];
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString* urlString = [NSString stringWithFormat:@"%@users/%@?fields=%@",SERVER_ENDPOINT,userId,jsonString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    // Access token required for request header
    NSString *authorization = [NSString stringWithFormat:@"Bearer %@",ACCESS_TOKEN];
    [request setValue:authorization forHTTPHeaderField:@"Authorization"];
    [request setValue:@"50,4" forHTTPHeaderField:@"From-Location"];
    [request setValue:@"yes" forHTTPHeaderField:@"X-Accept-Wrapped"];
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(conn) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
    [conn start];
    
}

#pragma mark NSUrl Connection Delagatre Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"Response is:%@",response);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error is:%@",error);
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [self.delegate sendUserProfileData:jsonResponse];
}

@end
