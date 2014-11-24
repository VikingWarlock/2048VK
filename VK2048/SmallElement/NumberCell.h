//
//  NumberCell.h
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCell : UIView

@property(nonatomic,assign)NSInteger CurrentNumber;
@property(nonatomic,assign)NSInteger WillDisplayNumber;
@property(nonatomic,strong)NSMutableArray *Animations;
@property(nonatomic,assign)NSInteger Position_X;
@property(nonatomic,assign)NSInteger Position_Y;


@end
