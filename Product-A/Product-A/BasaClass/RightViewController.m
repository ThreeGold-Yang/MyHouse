//
//  RightViewController.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RightViewController.h"


/*
 此类是为了减少重复控件的创建，写为一个父类，给 电台、阅读等控制器继承
*/
@interface RightViewController ()

@property(nonatomic,strong) UITapGestureRecognizer *tap;
@property(nonatomic,strong) UIScreenEdgePanGestureRecognizer *screenEdge;
@property(nonatomic,strong) UIPanGestureRecognizer *pan;
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];// 很关键
    [self.view addSubview:self.button ];
    [self.view addSubview:self.titleLabel];
    
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
    
    [self.view addGestureRecognizer:self.tap];
    [self.view addGestureRecognizer:self.screenEdge];
    [self.view addGestureRecognizer:self.pan];
}

-(UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(10, 20+10, 20, 20)];
        [_button setTitle:@"三" forState:(UIControlStateNormal)];
//        [_button setBackgroundImage:[UIImage imageNamed:@"navigation_icon.png"] forState:(UIControlStateNormal)];
        [_button addTarget:self action:@selector(showRootVC:) forControlEvents:(UIControlEventTouchUpInside)];
        [_button setTitleColor:PKCOLOR(25, 25, 25) forState:(UIControlStateNormal)];
    }
    return _button;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 20+10, 200, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = PKCOLOR(25, 25, 25);
    }
    return _titleLabel;
}

-(void)showRootVC:(UIButton *)btn
{
    [self ChangeFrameWithType:MoveTypeRight];
}

// 隐藏rootVC 或者 显示rootVC
-(void)ChangeFrameWithType:(MoveType)tpe
{
    CGRect newFrame = self.navigationController.view.frame;
    if (tpe == MoveTypeLeft)
    {
        self.button.userInteractionEnabled = YES;
        self.tap.enabled = NO;
        self.pan.enabled = NO;
        newFrame.origin.x = 0;
    }
    else if(tpe == MoveTypeRight)
    {
        self.tap.enabled = YES;
        self.button.userInteractionEnabled = NO;
        self.pan.enabled = YES;
        // 改变坐标原点
        newFrame.origin.x = kScreenWidth - KMoveDistance;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.frame = newFrame;
    }];
}

-(UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideRootVC:)];
    }
    return _tap;
}

-(void)hideRootVC:(UITapGestureRecognizer *)sender
{
    self.button.userInteractionEnabled = YES;
    self.tap.enabled = NO;
    [self ChangeFrameWithType:MoveTypeLeft];
}

-(UIScreenEdgePanGestureRecognizer *)screenEdge
{
    if (!_screenEdge) {
        _screenEdge = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panWithFinger:)];
        _screenEdge.edges = UIRectEdgeLeft;
    }
    return _screenEdge;
}

-(void)panWithFinger:(UIScreenEdgePanGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.navigationController.view.superview];
    //NSLog(@"%@",NSStringFromCGPoint(point));
    CGRect newFrame = self.navigationController.view.frame;
    newFrame.origin.x = point.x;
    [self constraintNewFrame:&newFrame];
    self.navigationController.view.frame = newFrame;
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self ChangeFrameWithType:MoveTypeRight];
    }
}

// 约束坐标
-(void)constraintNewFrame:(CGRect *)newFrame // *号是关键点
{
    if (newFrame ->origin.x >= kScreenWidth - KMoveDistance) {
        newFrame ->origin.x = kScreenWidth - KMoveDistance;
    }
    else if (newFrame ->origin.x <= 0)
    {
        newFrame ->origin.x = 0;
        
    }
   // NSLog(@"%f",newFrame->origin.x);
}

-(UIPanGestureRecognizer *)pan
{
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panShowRootVC:)];
        _pan.enabled = NO;
    }
    return _pan;
}

-(void)panShowRootVC:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.navigationController.view.superview];
    //NSLog(@"%@",NSStringFromCGPoint(point));
    CGRect newFrame = self.navigationController.view.frame;
    newFrame.origin.x = point.x;
    [self constraintNewFrame:&newFrame];
    self.navigationController.view.frame = newFrame;
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self ChangeFrameWithType:MoveTypeLeft];
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
