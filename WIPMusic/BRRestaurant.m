//
//  BRRestaurant.m
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import "BRRestaurant.h"
#import "BRUtilityClass.h"

@implementation BRRestaurant

-(id)initWithRestaurantsObject:(NSDictionary*)restuarant
{
    if (self = [super init])
    {
        self.name =  [BRUtilityClass getValidString:restuarant[@"name"]];
        self.backgroundImageURL = [BRUtilityClass getValidString:restuarant[@"backgroundImageURL"]];
        self.category = [BRUtilityClass getValidString:restuarant[@"category"]];
        
        if (restuarant[@"contact"] != (id)[NSNull null]) {
            self.contact = [[BRContact alloc] initWithContactObject:restuarant[@"contact"]];
        }
        if (restuarant[@"location"] != (id)[NSNull null]) {
            self.location = [[BRLocation alloc] initWithLocationObject:restuarant[@"location"]];
        }

    }
    return self;
}


@end
