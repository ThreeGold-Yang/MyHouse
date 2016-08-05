//
//  QQTableViewCell.h
//  UIAdvanced_Test_QQTeam
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowModel.h"
@interface QQTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *nameL;
@property(nonatomic,strong) UILabel *introL;

@property(nonatomic,strong) RowModel *rowModel;
@end
