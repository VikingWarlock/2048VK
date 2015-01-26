//
//  GameViewController.m
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "GameViewController.h"
#import "NumberCell.h"
#import "Constant.h"


typedef void(^DoneBlock)();

@interface GameViewController ()
{
    int CellData[4][4];
    NumberCell *Cells[4][4];

    NSMutableArray *Remaining;
    UIView *GameBoard;
    CGFloat CellWidth;
    CGFloat LineWidth;
    
    UISwipeGestureRecognizer *UpGesture;
    UISwipeGestureRecognizer *DownGesture;
    UISwipeGestureRecognizer *RightGesture;
    UISwipeGestureRecognizer *LeftGesture;

    UIView *controlMask;

    NSMutableArray *mergedArray;
    NSMutableArray *tomergeArray;
    
    NSInteger direction;
    NSInteger score;
    BOOL canUp;
    BOOL canDown;
    BOOL canLeft;
    BOOL canRight;
    
    BOOL isanimating;
    BOOL delayNewCell;
    
}
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    LineWidth=5.f;
    CellWidth=(self.view.frame.size.width-40.f-LineWidth*5)/4.f;
    Remaining=[NSMutableArray array];
    GameBoard=[[UIView alloc]initWithFrame:CGRectMake(20.f, 80.f, self.view.frame.size.width-40.f, self.view.frame.size.width-40.f)];
    [self.view addSubview:GameBoard];
    GameBoard.backgroundColor=GameBoardBackgroundColor;
    GameBoard.layer.cornerRadius=10.f;
    GameBoard.layer.masksToBounds=YES;
    for(int row =0;row<4;row++)
    {
        for(int column=0;column<4;column++)
        {
            UIView *cell=[[UIView alloc]initWithFrame:CGRectMake(column*CellWidth+(1+column)*LineWidth, row*CellWidth+(row+1)*LineWidth, CellWidth, CellWidth)];
            [GameBoard addSubview:cell];
            cell.backgroundColor=[UIColor colorWithWhite:1.f alpha:0.4f];
            cell.layer.cornerRadius=10.f;
            cell.layer.masksToBounds=YES;
            
            NumberCell *GameCell=[[NumberCell alloc]initWithPositionX:column AndY:row];
            GameCell.frame=[self FrameMakeWithRow:column AndColoum:row];
            [GameBoard bringSubviewToFront:GameCell];
            [GameCell setCellSize:CGSizeMake(CellWidth, CellWidth)];
            [GameBoard addSubview:GameCell];
            Cells[column][row]=GameCell;

        }
    }
    controlMask=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:controlMask];
    [self setupGesture];
    [self startGame];
    
    // Do any additional setup after loading the view.
}

-(void)setupGesture
{
    UpGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    UpGesture.direction=UISwipeGestureRecognizerDirectionUp;
    [controlMask addGestureRecognizer:UpGesture];
    
    DownGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    DownGesture.direction=UISwipeGestureRecognizerDirectionDown;
    [controlMask addGestureRecognizer:DownGesture];
    
    RightGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    RightGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [controlMask addGestureRecognizer:RightGesture];
    
    LeftGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    LeftGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [controlMask addGestureRecognizer:LeftGesture];

}

-(void)startGame
{
    for (int row=0; row<4; row++) {
        for (int coloum=0; coloum<4; coloum++) {
            [(Cells[row][coloum]) destoryNum];
            CellData[row][coloum]=0;
            [Remaining addObject:@(row*4+coloum)];
        }
    }
    
    canUp=YES;
    canRight=YES;
    canLeft=YES;
    canDown=YES;
    score=0;
    mergedArray=[NSMutableArray array];
    tomergeArray=[NSMutableArray array];
    [UIView animateWithDuration:0.3f animations:^{
        [self newCell];
        [self newCell];

    } completion:^(BOOL finished) {
//        [self debug];
        isanimating=NO;
        [self refreshMovementState];
    }];
    
    
}

-(BOOL)isWin
{
    return NO;
}

-(BOOL)isLost
{
    if (Remaining.count>0||canDown||canLeft||canRight||canUp) {
        return NO;
    }else
    return YES;
}

-(void)newCell
{
    int positionInArray=arc4random() % Remaining.count;
    NSInteger position = [Remaining[positionInArray] integerValue];
    NSInteger y_axis = position / 4 ;
    NSInteger x_asix = position - 4 * y_axis;
    
    
    if ([tomergeArray containsObject:Cells[x_asix][y_axis]]) {
        delayNewCell=YES;
    }else
    {
    
    int seed = arc4random() % 10 ;
    if (seed>=8) {
        [(Cells[x_asix][y_axis]) generateNum:4];
        (Cells[x_asix][y_axis]).CurrentNumber=4;
        CellData[x_asix][y_axis]=4;
    }else
    {
        [(Cells[x_asix][y_axis]) generateNum:2];
        (Cells[x_asix][y_axis]).CurrentNumber=2;
        CellData[x_asix][y_axis]=2;
    }
    [Remaining removeObject:@(position)];
    
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)mergeDown:(BOOL)down row:(NSInteger)row
{
    if (!down)
    {
        for (int i=0; i<3; i++)
        {
            for (int j =i+1; j<=3; j++) {
                if (i==j) {
                    break;
                }
                if (CellData[row][i]==0 && CellData[row][j]!=0) {
                    [self Down_moveJ:j toI:i coloum:row];
                }
                else if (CellData[row][i]==CellData[row][j] && CellData[row][i]!=0)
                {
                    [self Down_mergeJ:j toI:i coloum:row];
                    break;
                }else if (CellData[row][i]!=CellData[row][j]&&CellData[row][j]!=0&&CellData[row][i]!=0)
                {
                    break;
                }
            }
        }
    }else{
        for (int i=3; i>0; i--)
        {
            for (int j =i-1; j>=0; j--) {
                if (i==j) {
                    break;
                }
                if (CellData[row][i]==0 && CellData[row][j]!=0) {
                    [self Down_moveJ:j toI:i coloum:row];
                }
                else if (CellData[row][i]==CellData[row][j] && CellData[row][i]!=0)
                {
                    [self Down_mergeJ:j toI:i coloum:row];
                    break;

                }else if (CellData[row][i]!=CellData[row][j]&&CellData[row][j]!=0&&CellData[row][i]!=0)
                {
                    break;
                }
            }
            
        }
    
    }
}

-(void)mergeRight:(BOOL)right coloum:(NSInteger)coloum
{
    if (!right)
    {
        for (int i=0; i<3; i++)
        {
            for (int j =i+1; j<=3; j++) {
                if (i==j) {
                    break;
                }
                if (CellData[i][coloum]==0 && CellData[j][coloum]!=0) {
                    [self Right_moveJ:j toI:i coloum:coloum];
                }else
                if (CellData[i][coloum]==CellData[j][coloum] && CellData[i][coloum]!=0) {
                    [self Right_mergeJ:j toI:i coloum:coloum];
                    break;
                }else if (CellData[i][coloum]!=CellData[j][coloum]&&CellData[j][coloum]!=0&&CellData[i][coloum]!=0)
                {
                    break;
                }
            }
        }
    }else{
        for (int i=3; i>0; i--)
        {
            for (int j =i-1; j>=0; j--) {
                if (i==j) {
                    break;
                }
                if (CellData[i][coloum]==0 && CellData[j][coloum]!=0) {
                    [self Right_moveJ:j toI:i coloum:coloum];
                }else
                    if (CellData[i][coloum]==CellData[j][coloum] && CellData[i][coloum]!=0) {
                        [self Right_mergeJ:j toI:i coloum:coloum];
                        break;
                    }else if (CellData[i][coloum]!=CellData[j][coloum]&&CellData[j][coloum]!=0&&CellData[i][coloum]!=0)
                    {
                        break;
                    }
            }
        }
        
    }
}

-(void)Right_mergeJ:(int)j toI:(int)i coloum:(NSInteger)coloum
{
    score+=CellData[i][coloum];
    CellData[i][coloum]=CellData[i][coloum]+CellData[j][coloum];
    Cells[i][coloum].CurrentNumber=CellData[i][coloum];
    
    CellData[j][coloum]=0;
    Cells[j][coloum].CurrentNumber=CellData[j][coloum];
    
    [(Cells[i][coloum]) changeNumTo:(CellData[i][coloum])];
    [GameBoard bringSubviewToFront:Cells[i][coloum]];
    (Cells[j][coloum]).frame=[self FrameMakeWithRow:i AndColoum:coloum];
    if (![tomergeArray containsObject:(Cells[j][coloum])]) {
        [tomergeArray addObject:(Cells[j][coloum])];
    }
    if (![mergedArray containsObject:Cells[i][coloum]]) {
        [mergedArray addObject:(Cells[i][coloum])];
    }
}

-(void)Right_moveJ:(int)j toI:(int)i coloum:(NSInteger)coloum
{
    CellData[i][coloum]=CellData[j][coloum];
    
    Cells[i][coloum].CurrentNumber=CellData[i][coloum];
    
    (Cells[j][coloum]).frame=[self FrameMakeWithRow:i AndColoum:coloum];
    Cells[i][coloum].CurrentNumber=CellData[j][coloum];
    
    CellData[j][coloum]=0;
    Cells[j][coloum].CurrentNumber=CellData[j][coloum];
    
    
    if (![tomergeArray containsObject:(Cells[j][coloum])]) {
        [tomergeArray addObject:(Cells[j][coloum])];
    }else
    {
        
    }
    if (![mergedArray containsObject:Cells[i][coloum]]) {
        [mergedArray addObject:(Cells[i][coloum])];
    }
}


-(void)Down_mergeJ:(int)j toI:(int)i coloum:(NSInteger)coloum
{
    score+=CellData[coloum][i];
    CellData[coloum][i]=CellData[coloum][i]+CellData[coloum][j];
    Cells[coloum][i].CurrentNumber=CellData[coloum][i];
    
    CellData[coloum][j]=0;
    Cells[coloum][j].CurrentNumber=CellData[coloum][j];
    
    [(Cells[coloum][i]) changeNumTo:(CellData[coloum][i])];
    [GameBoard bringSubviewToFront:Cells[coloum][i]];
    (Cells[coloum][j]).frame=[self FrameMakeWithRow:coloum AndColoum:i];
    if (![tomergeArray containsObject:(Cells[coloum][j])]) {
        [tomergeArray addObject:(Cells[coloum][j])];
    }
    if (![mergedArray containsObject:Cells[coloum][i]]) {
        [mergedArray addObject:(Cells[coloum][i])];
    }
}

-(void)Down_moveJ:(int)j toI:(int)i coloum:(NSInteger)coloum
{
    CellData[coloum][i]=CellData[coloum][j];
    
    Cells[coloum][i].CurrentNumber=CellData[coloum][i];
    
    (Cells[coloum][j]).frame=[self FrameMakeWithRow:coloum AndColoum:i];
    Cells[coloum][i].CurrentNumber=CellData[coloum][j];
    
    CellData[coloum][j]=0;
    Cells[coloum][j].CurrentNumber=CellData[coloum][j];
    
    
    if (![tomergeArray containsObject:(Cells[coloum][j])]) {
        [tomergeArray addObject:(Cells[coloum][j])];
    }
    if (![mergedArray containsObject:Cells[coloum][i]]) {
        [mergedArray addObject:(Cells[coloum][i])];
    }
}



-(void)handleGesture:(UISwipeGestureRecognizer*)sender
{
    switch (sender.state) {
        case UIGestureRecognizerStateEnded:
        {
            switch (sender.direction) {
                case UISwipeGestureRecognizerDirectionDown:
                {
                    [self goDown];
                    break;
                }
                case UISwipeGestureRecognizerDirectionLeft:
                {
                    [self goLeft];
                    break;
                }
                case UISwipeGestureRecognizerDirectionRight:
                {
                    [self goRight];
                    break;
                }
                default:
                {
                    [self goUp];
                    break;
                }
            }
            break;
        }
        default:
            break;
    }
}

-(void)goUp
{
    if (isanimating) {
        return;
    }
    if (!canUp) {
        return;
    }
    NSLog(@"\n\n\n\nup move");

    direction=UISwipeGestureRecognizerDirectionUp;
    isanimating=YES;

    [UIView animateWithDuration:0.1f animations:^{
        for (int i=0; i<4; i++) {
            [self mergeDown:NO row:i];
        }
    } completion:^(BOOL finished) {
//        [self debug];
        [self refreshRemainList];
        [UIView animateWithDuration:0.1f animations:^{
            [self newCell];
        } completion:^(BOOL finished) {
            [self afterMovement];
        }];
    }];
}

-(void)goDown
{
    if (isanimating) {
        return;
    }
    if (!canDown) {
        return;
    }
    NSLog(@"\n\n\n\ndown move");

    direction=UISwipeGestureRecognizerDirectionDown;
    isanimating=YES;
    [UIView animateWithDuration:0.1f animations:^{
        for (int i=0; i<4; i++) {
            [self mergeDown:YES row:i];
        }
    } completion:^(BOOL finished) {
//        [self debug];
        [self refreshRemainList];
        [UIView animateWithDuration:0.1f animations:^{
            [self newCell];
        } completion:^(BOOL finished) {
            [self afterMovement];
        }];
    }];
}

-(void)goLeft
{

    if (isanimating) {
        return;
    }
    if (!canLeft) {
        return;
    }
    NSLog(@"\n\n\n\nleft move");

    direction=UISwipeGestureRecognizerDirectionLeft;
    isanimating=YES;

    [UIView animateWithDuration:0.1f animations:^{
        for (int i=0; i<4; i++) {
            [self mergeRight:NO coloum:i];
        }
    } completion:^(BOOL finished) {
//        [self debug];
        [self refreshRemainList];
        [UIView animateWithDuration:0.1f animations:^{
            [self newCell];
        } completion:^(BOOL finished) {
            [self afterMovement];
        }];
    }];
}

-(void)goRight
{
    if (isanimating) {
        return;
    }
    if (!canRight) {
        return;
    }
    NSLog(@"\n\n\n\nright move");

    direction=UISwipeGestureRecognizerDirectionRight;
    isanimating=YES;

    [UIView animateWithDuration:0.1f animations:^{
        for (int i=0; i<4; i++) {
            [self mergeRight:YES coloum:i];
        }
    } completion:^(BOOL finished) {
//        [self debug];
        [self refreshRemainList];
        [UIView animateWithDuration:0.1f animations:^{
            [self newCell];
        } completion:^(BOOL finished) {
            [self afterMovement];
        }];
    }];
}


-(void)afterMovement
{

    for(NumberCell * item in tomergeArray)
    {
        [item destoryNum];
        item.frame=CGRectMake(item.Position_X*CellWidth+(1+item.Position_X)*LineWidth, item.Position_Y*CellWidth+(item.Position_Y+1)*LineWidth, CellWidth, CellWidth);
    }
    for(NumberCell * item in mergedArray)
    {
        [item changeNumTo:item.CurrentNumber];
    }
    [tomergeArray removeAllObjects];
    [mergedArray removeAllObjects];
    
    if (delayNewCell) {
        [UIView animateWithDuration:0.3f animations:^{
            [self newCell];
        } completion:^(BOOL finished) {
//            [self debug];
            delayNewCell=NO;
            [self refreshMovementState];
            isanimating=NO;
            if ([self isLost]) {
                [self startGame];
            }
        }];
    }else
    {
//    [self debug];
    [self refreshMovementState];
    isanimating=NO;
    if ([self isLost]) {
    [self startGame];
    }
    }
}

-(CGRect)FrameMakeWithRow:(NSInteger)row AndColoum:(NSInteger)coloum
{
    return CGRectMake(row*CellWidth+(1+row)*LineWidth, coloum*CellWidth+(coloum+1)*LineWidth, CellWidth, CellWidth);
}


-(void)refreshRemainList
{
    [Remaining removeAllObjects];
    for (int row=0; row<4; row++) {
        for (int coloum=0; coloum<4; coloum++) {
            if (CellData[coloum][row]==0) {
                [Remaining addObject:@(coloum+row*4)];
            }
        }
    }
}

-(void)debug
{
    for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++) {
                printf("%d ",CellData[j][i]);
        }
        printf("\n");
    }

}

-(void)refreshMovementState
{
    canDown=NO;
    canUp=NO;
    canRight=NO;
    canLeft=NO;

    [self debug];
    
    for (int i=0; i<4; i++) {
        for (int j=0; j<4; j++) {

            if (CellData[j][i]==0) {
                if (i-1>=0) {
                    if ((!canDown)&&CellData[j][i-1]!=0) {
                        canDown=YES;
                        NSLog(@"can down at %d %d",j,i-1);
                    }
                }
                if (j-1>=0) {
                    if ((!canRight)&&CellData[j-1][i]!=0) {
                        canRight=YES;
                        NSLog(@"can right at %d %d",j-1,i);
                    }
                }
                if (i+1<4) {
                    if ((!canUp)&&CellData[j][i+1]!=0) {
                        canUp=YES;
                        NSLog(@"can up at %d %d",j,i+1);
                    }
                }
                if (j+1<4) {
                    if ((!canLeft)&&CellData[j+1][i]!=0) {
                        canLeft=YES;
                        NSLog(@"can left at %d %d",j+1,i);
                    }
                }
                if (canDown&&canLeft&&canRight&&canUp) {
                    return;
                }
            }
        }
        for (int k=0; k<3; k++) {
            if (((!canUp)||(!canDown))&&(CellData[i][k]!=0))
            {
                if (CellData[i][k]==CellData[i][k+1]) {
                    canUp=YES;
                    canDown=YES;
                    NSLog(@"can up can down at %d %d",i,k);
                }
            }
            if (((!canRight)||(!canLeft))&&(CellData[k][i]!=0))
            {
                if (CellData[k][i]==CellData[k+1][i])
                {
                    canRight=YES;
                    canLeft=YES;
                    NSLog(@"can right can left at %d %d",k,i);
                }
            }
            if (canRight&canUp&canLeft&canDown) {
                return;
            }
        }
    
    }
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
