//
//  DetailsViewController.h
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
@interface DetailsViewController : UIViewController

@property(nonatomic,strong) UIImageView *imageV1;
@property(nonatomic,strong) UILabel *nameL1;
@property(nonatomic,strong) UILabel *nameL2;
@property(nonatomic,strong) UILabel *sexL1;
@property(nonatomic,strong) UILabel *ageL1;
@property(nonatomic,strong) UILabel *numberL1;
@property(nonatomic,strong) UILabel *numberL2;
@property(nonatomic,strong) UILabel *introduceL1;

@property(nonatomic,strong) Contact *person;

@end
