//
//  DIYAddContactView.m
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "DIYAddContactView.h"

@implementation DIYAddContactView

// 重写父类方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 120, 150)];
        self.imageV.backgroundColor = [UIColor grayColor];
        [self addSubview:self.imageV];
        
        self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(130, 10, 200, 30)];
        self.nameTF.borderStyle = UITextBorderStyleRoundedRect;
        self.nameTF.placeholder = @"姓名";
        [self addSubview:self.nameTF];
        
        self.sexTF = [[UITextField alloc]initWithFrame:CGRectMake(130, 70, 50, 30)];
        self.sexTF.borderStyle = UITextBorderStyleRoundedRect;
        self.sexTF.placeholder = @"性别";
        [self addSubview:self.sexTF];
        
        self.ageTF = [[UITextField alloc]initWithFrame:CGRectMake(200, 70, 50, 30)];
        self.ageTF.borderStyle = UITextBorderStyleRoundedRect;
        self.ageTF.placeholder = @"年纪";
        self.ageTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.ageTF];
        
        self.numberTF = [[UITextField alloc]initWithFrame:CGRectMake(130, 130, 200, 30)];
        self.numberTF.borderStyle = UITextBorderStyleRoundedRect;
        self.numberTF.placeholder = @"联系方式";
        self.numberTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:self.numberTF];
        
        self.introduceTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 190, self.frame.size.width, 200)];
        self.introduceTF.backgroundColor = [UIColor blueColor];
        self.introduceTF.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:self.introduceTF];
    }
    return self;
}

@end
