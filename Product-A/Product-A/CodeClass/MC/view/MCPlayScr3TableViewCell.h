//
//  MCPlayScr3TableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCXQXiaBanModel.h"

@interface MCPlayScr3TableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *musicNameL;
@property(nonatomic,strong) UILabel *musicPersonL;
@property(nonatomic,strong) UIButton *downLoadBtn;

@property(nonatomic,strong) MCXQXiaBanModel *model;
@end
