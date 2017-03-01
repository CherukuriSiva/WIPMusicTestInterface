//
//  BRUtilityClass.m
//  Lechal
//
//  Created by Ducere on 30/03/16.
//  Copyright © 2016 Ducere. All rights reserved.
//

#import "BRUtilityClass.h"

@implementation BRUtilityClass

+(NSString*)getValidString:(NSString*)inputString
{
    if ([inputString isKindOfClass:[NSString class]] && [inputString length] > 1) {
        return inputString;
    }else{
        return @"";
    }
}

+(UIBarButtonItem*)barbuttonItemWithImage:(NSString*)image Target:(id)target action:(SEL)action
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:image]
                                                             style:UIBarButtonItemStylePlain
                                                            target:target
                                                            action:action];
    return item;
}
@end
