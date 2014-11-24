//
//  GameViewController.m
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "GameViewController.h"
#import "NumberCell.h"

@interface GameViewController ()
{
    void *CellData[4][4];
    NumberCell *Cells[4][4];
    int SwipeDirect[2];
    int InverseDirect[2];
    int ScanDirect[2];
}
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i<4; i++) {
        Cells[0][i]=[[NumberCell alloc]init];
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
