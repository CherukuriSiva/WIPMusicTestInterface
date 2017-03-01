//
//  BRContact.m
//  BR iOS Test
//
//  Created by Apple on 09/11/16.
//  Copyright © 2016 Bottle Rocket. All rights reserved.
//

#import "BRContact.h"
#import "BRUtilityClass.h"

@implementation BRContact

-(id)initWithContactObject:(NSDictionary*)contact
{
    
    if (self = [super init])
    {
        self.phone = [BRUtilityClass getValidString:contact[@"phone"]];
        self.formattedPhone = [BRUtilityClass getValidString:contact[@"formattedPhone"]];
        self.twitter = [BRUtilityClass getValidString:contact[@"twitter"]];
    }
    return self;
}
@end
