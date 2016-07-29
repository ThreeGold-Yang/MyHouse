//
//  CommNewTwoTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommShouYeModel.h"
@interface CommNewTwoTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UILabel *contentL;
@property(nonatomic,strong) UILabel *dayL;
@property(nonatomic,strong) UIImageView *pinglunImageV;
@property(nonatomic,strong) UILabel *pinglunNumL;

@property(nonatomic,strong) CommShouYeModel *model;

@end
