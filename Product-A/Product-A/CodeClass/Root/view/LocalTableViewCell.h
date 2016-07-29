//
//  LocalTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UIButton *chooseBtn;

@property(nonatomic,assign) BOOL isChoose;
@end
