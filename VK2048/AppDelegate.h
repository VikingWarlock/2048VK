//
//  AppDelegate.h
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UINavigationController *BaseNavitgation;

+(AppDelegate*)shared;


@end

