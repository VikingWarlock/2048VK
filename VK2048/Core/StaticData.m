//
//  StaticData.m
//  VK2048
//
//  Created by viking warlock on 1/26/15.
//  Copyright (c) 2015 viking warlock. All rights reserved.
//

#import "StaticData.h"

static StaticData *shared;
static NSArray *colorPattern;

@implementation StaticData
{
}

+(void)setup
{
    if (!shared) {
        shared=[[StaticData alloc]init];
    }
    colorPattern=[NSArray arrayWithObjects:
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //2
    [UIColor colorWithRed:253.f/255.f green:209.f/255.f blue:2.f/255.f alpha:1.f],
    //4
    [UIColor colorWithRed:253.f/255.f green:232.f/255.f blue:2.f/255.f alpha:1.f],
    //8
    [UIColor colorWithRed:173.f/255.f green:253.f/255.f blue:2.f/255.f alpha:1.f],
    //16
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //32
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //64
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //128
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //256
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //512
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //1024
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //2048
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //4096
    [UIColor colorWithRed:253.f/255.f green:173.f/255.f blue:2.f/255.f alpha:1.f],
    //8192
    nil];
}

+(UIColor*)colorWithNumber:(NSInteger)number
{
    NSInteger index = (NSInteger) log2f(number);
    return colorPattern[index];
}

@end
