//
//  UserMediaData.h
//  WIPMusic
//
//  Created by Apple on 19/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserMediaDelegate <NSObject>
@optional
-(void)sendUserMeidaData:(NSDictionary*)eventsData;
@end

@interface UserMediaData : NSObject
@property(nonatomic, weak) id<UserMediaDelegate> delegate;
- (void)getUsersMediaDataForUserId:(NSString*)userId;
@end
