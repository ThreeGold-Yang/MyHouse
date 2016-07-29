//
//  McBiaoTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCBiaoModel.h"
@interface McBiaoTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UILabel *unameL;
@property(nonatomic,strong) UILabel *contentL;
@property(nonatomic,strong) UIImageView *wifiV;
@property(nonatomic,strong) UILabel *shouTingNumL;

@property(nonatomic,strong) MCBiaoModel *model;
@end
