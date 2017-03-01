//
//  AppDelegate.h
//  WIPMusic
//
//  Created by Apple on 18/12/16.
//  Copyright © 2016 WIPMusic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

