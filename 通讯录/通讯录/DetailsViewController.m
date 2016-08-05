//
//  DetailsViewController.m
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:self action:@selector(backBtnAction)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    self.navigationItem.title = self.person.name;
    
    self.imageV1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 120, 150)];
    self.imageV1.image = [UIImage imageNamed:self.person.icon];
    [self.view addSubview:self.imageV1];
    
    self.nameL1 = [[UILabel alloc]initWithFrame:CGRectMake(130, 0, 50, 30)];
    self.nameL1.text = @"姓名";
    [self.view addSubview:self.nameL1];
    
    self.nameL2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, 150, 30)];
    self.nameL2.backgroundColor = [UIColor grayColor];
    self.nameL2.text = self.person.name;
    [self.view addSubview:self.nameL2];
    
    self.sexL1 = [[UILabel alloc]initWithFrame:CGRectMake(130, 60, 50, 30)];
    self.sexL1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.sexL1];
    
    self.ageL1 = [[UILabel alloc]initWithFrame:CGRectMake(200, 60, 80, 30)];
    self.ageL1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.ageL1];
    
    self.numberL1 = [[UILabel alloc]initWithFrame:CGRectMake(130, 120, 50, 30)];
    self.numberL1.text = @"电话";
    [self.view addSubview:self.numberL1];
    
    self.numberL2 = [[UILabel alloc]initWithFrame:CGRectMake(180, 120, 150, 30)];
    self.numberL2.text = self.person.number;
    self.numberL2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.numberL2];
    
    self.introduceL1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 200)];
    self.introduceL1.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.introduceL1];

    
}

-(void)backBtnAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}









@end
