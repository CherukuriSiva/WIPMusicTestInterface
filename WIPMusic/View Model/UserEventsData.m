//
//  UserEventsData.m
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import "UserEventsData.h"
#import "Constants.h"

@implementation UserEventsData

- (void)getUsersEventsDataForUserId:(NSString*)userId
{
    
    NSString* urlString = [NSString stringWithFormat:@"%@users/%@/events",SERVER_ENDPOINT,userId];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
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
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error is:%@",error);
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [self.delegate sendUserEventsData:jsonResponse];
}

@end
