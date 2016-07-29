//
//  MCXQTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCXQXiaBanModel.h"
@interface MCXQTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UIImageView *wifiV;
@property(nonatomic,strong) UILabel *listenNumL;
@property(nonatomic,strong) UIImageView *playerV;

@property(nonatomic,strong) MCXQXiaBanModel *model;
@end
