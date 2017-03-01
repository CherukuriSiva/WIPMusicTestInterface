//
//  UserMediaData.m
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import "UserMediaData.h"
#import "Constants.h"

@implementation UserMediaData

- (void)getUsersMediaDataForUserId:(NSString*)userId
{
    
    NSMutableArray* profileArray = [NSMutableArray new];
    [profileArray addObject:@"self_feeling"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:profileArray options:0 error:nil];
    
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    NSString* urlString = [NSString stringWithFormat:@"%@users/%@?medias?fields=%@",SERVER_ENDPOINT,userId,jsonString];
    
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
    //(@"Response is:%@",response);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error is:%@",error);
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSDictionary* jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [self.delegate sendUserMeidaData:jsonResponse];
}
@end

//    if([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] isKindOfClass:[NSDictionary class]])
//    {
//        NSLog(@"Dictionary");
//    }
//    else if([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] isKindOfClass:[NSArray class]])
//    {
//        NSLog(@"Array");
//    }
//    else if([[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] isKindOfClass:[NSString class]])
//    {
//        NSLog(@"String");
//    }

