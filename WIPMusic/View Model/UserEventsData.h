//
//  UserEventsData.h
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserEventsDelegate <NSObject>
@optional
-(void)sendUserEventsData:(NSDictionary*)eventsData;
@end

@interface UserEventsData : NSObject
@property(nonatomic, weak) id<UserEventsDelegate> delegate;
- (void)getUsersEventsDataForUserId:(NSString*)userId;
@end
