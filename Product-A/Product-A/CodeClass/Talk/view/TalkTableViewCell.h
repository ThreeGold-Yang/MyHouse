//
//  TalkTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinLunModel.h"
@interface TalkTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *unameL;
@property(nonatomic,strong) UILabel *timeL;
@property(nonatomic,strong) UILabel *talkContentL;

@property(nonatomic,strong) PinLunModel *model;
@end
