//
//  TopViewController.m
//  Prodcut-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "TopViewController.h"

@interface TopViewController ()


@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationBar];
    
    
    
    
}
-(void)initNavigationBar
{
    UIButton * _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 40, 40)];
    [_button setTitleColor:PKCOLOR(40, 40, 40) forState:(UIControlStateNormal)];
    [_button setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
    [_button addTarget:self action:@selector(popVC:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_button];
    UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(KNaviH, 20, 1, KNaviH)];
    verticalLine.backgroundColor = PKCOLOR(200, 200, 200);
    [self.view addSubview:verticalLine];
    UIView *horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(0, KNaviH + 19, kScreenWidth, 1)];
    horizontalLine.backgroundColor = PKCOLOR(200, 200, 200);
    [self.view addSubview:horizontalLine];
//    [self.view addSubview:self.titleLabel];
    
}
-(void)popVC:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 150, 40)];
//        _titleLabel.font = [UIFont systemFontOfSize:18];
//        _titleLabel.backgroundColor = [UIColor redColor];
//        _titleLabel.textColor = PKCOLOR(25, 25, 25);
//    }
//    return _titleLabel;
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
