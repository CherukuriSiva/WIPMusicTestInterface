//
//  BRUtilityClass.h
//  Lechal
//
//  Created by Ducere on 30/03/16.
//  Copyright © 2016 Ducere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BRUtilityClass : NSObject
+(NSString*)getValidString:(NSString*)inputString;
+(UIBarButtonItem*)barbuttonItemWithImage:(NSString*)image Target:(id)target action:(SEL)action;
@end
