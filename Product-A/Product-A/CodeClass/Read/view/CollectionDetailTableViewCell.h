//
//  CollectionDetailTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionDetailModel.h"
@interface CollectionDetailTableViewCell : UITableViewCell
@property(nonatomic,strong) UILabel *titL;
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *intrL;

@property(nonatomic,strong) CollectionDetailModel *model;
@end
