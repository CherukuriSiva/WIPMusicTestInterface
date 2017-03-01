//
//  BRRestaurant.h
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BRContact.h"
#import "BRLocation.h"

@interface BRRestaurant : NSObject
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* backgroundImageURL;
@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) BRContact* contact;
@property (strong, nonatomic) BRLocation* location;
-(id)initWithRestaurantsObject:(NSDictionary*)restuarant;
@end
