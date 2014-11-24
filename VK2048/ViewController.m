//
//  ViewController.m
//  VK2048
//
//  Created by viking warlock on 11/23/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"


@interface ViewController ()
{
    CGRect ViewFrame;
    
    UIButton *GameStart;
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewFrame=self.view.frame;
    
    GameStart=[[UIButton alloc]initWithFrame:CGRectMake(ViewFrame.size.width*0.05f, ViewFrame.size.height*0.1f, ViewFrame.size.width*0.9f, ViewFrame.size.height*0.1)];
    [self.view addSubview:GameStart];
    [GameStart setTitle:@"Start Game" forState:UIControlStateNormal];
    [GameStart addTarget:self action:@selector(gameStart) forControlEvents:UIControlEventTouchUpInside];
    [GameStart setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)gameStart
{
    GameViewController *gameVC=[[GameViewController alloc]init];
    [self.navigationController pushViewController:gameVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
