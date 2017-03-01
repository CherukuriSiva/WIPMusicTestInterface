//
//  UserProfileData.h
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserProfileDelegate <NSObject>
@optional
-(void)sendUserProfileData:(NSDictionary*)eventsData;
@end

@interface UserProfileData : NSObject
@property(nonatomic, weak) id<UserProfileDelegate> delegate;
- (void)getUsersProfileDataForUserId:(NSString*)userId;
@end
