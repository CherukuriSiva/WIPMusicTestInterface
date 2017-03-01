//
//  BRLocation.h
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRLocation : NSObject
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* cc;
@property (strong, nonatomic) NSString* city;
@property (strong, nonatomic) NSString* country;
@property (strong, nonatomic) NSString* crossStreet;
@property (strong, nonatomic) NSString* formattedAddress;
@property (strong, nonatomic) NSString* lat;
@property (strong, nonatomic) NSString* lng;
@property (strong, nonatomic) NSString* postalCode;
@property (strong, nonatomic) NSString* state;
-(id)initWithLocationObject:(NSDictionary*)location;
@end
