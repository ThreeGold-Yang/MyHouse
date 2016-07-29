//
//  LoginViewController.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
// 状态栏白色高亮字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH+1, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];

    
}

- (IBAction)loginVCBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)LoginVCLogin:(id)sender
{
    NSDictionary *params = @{@"email":self.loginVCEmilTF.text,@"passwd":self.loginVCPwdTF.text};
    [RequestManager requestDataWithUrlString:kLoginUrl parDic:params finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"result"] integerValue] == 0) {
            //NSLog(@"登录失败");
            //NSLog(@"%@",[dic[@"data"] valueForKey:@"msg"]);
        }
        else
        {
            [UserInfoManager conserveUserAuth:dic[@"data"][@"auth"]];
            [UserInfoManager conserveUserIcon:dic[@"data"][@"icon"]];
            [UserInfoManager conserveUserID:dic[@"data"][@"uid"]];
            [UserInfoManager conserveUserName:dic[@"data"][@"uname"]];
            //NSLog(@"登录成功");
            if (self.loginSuccess) {
                self.loginSuccess();
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } error:^(NSError *error) {
        //NSLog(@"%@",error);
    }];

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
