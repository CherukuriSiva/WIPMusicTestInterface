//
//  BRContact.h
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRContact : NSObject
@property (strong, nonatomic) NSString* phone;
@property (strong, nonatomic) NSString* formattedPhone;
@property (strong, nonatomic) NSString* twitter;
-(id)initWithContactObject:(NSDictionary*)contact;
@end
