//
//  ViewController.m
//  试写跑马灯
//
//  Created by lanou on 16/6/4.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)UIView *bigView;
@property(nonatomic,weak)UILabel *lab;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self getView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(backFram) userInfo:nil repeats:YES];
    
    
    
}

-(void)getView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewX = (self.view.frame.size.width-200)/2;
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(viewX, 50, 200, 50)];
    bigView.backgroundColor = [UIColor yellowColor];
    bigView.clipsToBounds = YES;
    self.bigView = bigView;
    [self.view addSubview:bigView];
    
    CGFloat customLabY = (self.bigView.frame.size.height - 30)/2;
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(self.bigView.frame.size.width, customLabY, 300, 30)];
//    lab.backgroundColor = [UIColor redColor];
    lab.textColor = [UIColor redColor];
    lab.text = @"这就是跑马灯效果";
    self.lab = lab;
    [self.bigView addSubview:lab];
}

-(void)backFram
{
    CGPoint curPos = self.lab.center;
    NSLog(@"%f",self.lab.center.x);
    // 当curPos的x坐标已经超过了屏幕的宽度
    if(curPos.x <  -100 )
    {
        CGFloat jianJu = self.lab.frame.size.width/2;
        // 控制lab再次从屏幕左侧开始移动
        self.lab.center = CGPointMake(self.bigView.frame.size.width + jianJu, 20);
        
    }
    else
    {
        // 通过修改的center属性来改变lab的位置
        self.lab.center = CGPointMake(curPos.x - 5, 20);
    }
    //lab的整个移动都是靠center来去设置的

}


@end
