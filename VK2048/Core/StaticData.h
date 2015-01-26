//
//  StaticData.h
//  VK2048
//
//  Created by viking warlock on 1/26/15.
//  Copyright (c) 2015 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StaticData : NSObject

+(void)setup;
+(UIColor*)colorWithNumber:(NSInteger)number;

@end
