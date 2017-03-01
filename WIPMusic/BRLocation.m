//
//  BRLocation.m
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import "BRLocation.h"
#import "BRUtilityClass.h"

@implementation BRLocation

-(id)initWithLocationObject:(NSDictionary*)location
{
    
    if (self = [super init])
    {
        self.address = [BRUtilityClass getValidString:location[@"address"]];
        self.cc = [BRUtilityClass getValidString:location[@"cc"]];
        self.city = [BRUtilityClass getValidString:location[@"city"]];
        self.country = [BRUtilityClass getValidString:location[@"country"]];
        self.crossStreet = [BRUtilityClass getValidString:location[@"crossStreet"]];
        self.formattedAddress = [BRUtilityClass getValidString:[location[@"formattedAddress"] componentsJoinedByString:@","]];
        self.lat = location[@"lat"];
        self.lng = location[@"lng"];
        self.postalCode = [BRUtilityClass getValidString:location[@"postalCode"]];
        self.state = [BRUtilityClass getValidString:location[@"state"]];
        
    }
    return self;
}

@end
