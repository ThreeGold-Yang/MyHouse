//
//  AddContactViewController.m
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AddContactViewController.h"

@interface AddContactViewController ()

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    DIYAddContactView *addContaceView = [[DIYAddContactView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"添加联系人";
    
    [self.view addSubview:addContaceView];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStyleDone) target:self action:@selector(cancelBtnAction)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
    
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveBtnAction)];
    self.navigationItem.rightBarButtonItem = saveBtn;
    
}

#pragma mark --- 按钮方法
-(void)cancelBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
