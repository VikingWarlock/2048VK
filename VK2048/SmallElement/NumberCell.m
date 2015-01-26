//
//  NumberCell.m
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "NumberCell.h"
#import "StaticData.h"
#import "Constant.h"

@interface NumberCell()
{
    UILabel *NumberLabel;
    UIPanGestureRecognizer *gesture;
}
@end

@implementation NumberCell


-(id)initWithPositionX:(NSInteger)x_axis AndY:(NSInteger)y_axis
{
    self=[super init];
    if (self) {
        self.CurrentNumber=0;
        self.WillDisplayNumber=0;
        self.Position_X=x_axis;
        self.Position_Y=y_axis;
        NumberLabel=[[UILabel alloc]init];
        NumberLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:NumberLabel];
        NumberLabel.textColor=[UIColor blackColor];
        NumberLabel.backgroundColor=[UIColor colorWithWhite:1 alpha:0.5f];
        NumberLabel.layer.cornerRadius=5.f;
        NumberLabel.layer.masksToBounds=YES;
    
    }
    return self;
}

-(void)generateNum:(NSInteger)number
{
    if (number==0) {
        return;
    }
    if (number!=0) {
        NumberLabel.backgroundColor=[StaticData colorWithNumber:number];
    }
    NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)number];
    NumberLabel.transform=self.LabelTransform;
}

-(void)changeNumTo:(NSInteger)number
{
    if (number!=0) {
        NumberLabel.backgroundColor=[StaticData colorWithNumber:number];
        NumberLabel.text=[NSString stringWithFormat:@"%ld",(long)number];
        NumberLabel.transform=self.LabelTransform;
    }else
    {
        NumberLabel.backgroundColor=[UIColor clearColor];
        NumberLabel.text=@"";
        NumberLabel.transform=CGAffineTransformScale(self.LabelTransform, 0, 0);

    }
}

-(void)destoryNum
{
    NumberLabel.text=@"";
    NumberLabel.backgroundColor=[UIColor clearColor];
    NumberLabel.transform=CGAffineTransformScale(self.LabelTransform, 0, 0);
}

-(void)setCellSize:(CGSize)size
{
    NumberLabel.frame=CGRectMake(3, 3, size.width-6, size.height-6);
    
    self.LabelTransform=NumberLabel.transform;
    NumberLabel.transform=CGAffineTransformScale(self.LabelTransform, 0, 0);
    NumberLabel.text=@"";
    NumberLabel.font=[UIFont boldSystemFontOfSize:25];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
