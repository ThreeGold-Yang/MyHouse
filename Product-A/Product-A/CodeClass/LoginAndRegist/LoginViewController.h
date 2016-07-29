//
//  LoginViewController.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LoginSuccess)();

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *loginVCEmilTF;
@property (strong, nonatomic) IBOutlet UITextField *loginVCPwdTF;

@property(nonatomic,copy) LoginSuccess loginSuccess;
@end
