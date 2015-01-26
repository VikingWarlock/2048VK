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
@property(nonatomic,assign)NSInteger Position_X;
@property(nonatomic,assign)NSInteger Position_Y;
@property(nonatomic,assign)CGAffineTransform LabelTransform;

-(void)generateNum:(NSInteger)number;
-(void)changeNumTo:(NSInteger)number;
-(void)destoryNum;
-(id)initWithPositionX:(NSInteger)x_axis AndY:(NSInteger)y_axis;
-(void)setCellSize:(CGSize)size;

@end
