//
//  LiangPinShouYeTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiangPinShouYeModel.h"
@interface LiangPinShouYeTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UIButton *buyBtn;

@property(nonatomic,strong) LiangPinShouYeModel *model;
@end
