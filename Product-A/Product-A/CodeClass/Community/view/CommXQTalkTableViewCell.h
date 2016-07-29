//
//  CommXQTalkTableViewCell.h
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommXQTalkModel.h"
@interface CommXQTalkTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView *talkPerImageV;
@property(nonatomic,strong) UILabel *talkPerL;
@property(nonatomic,strong) UILabel *talkDayL;
@property(nonatomic,strong) UILabel *talkContentL;
@property(nonatomic,strong) UIButton *zanBtn;
@property(nonatomic,strong) UILabel *zanNumL;

@property(nonatomic,strong) CommXQTalkModel *model;

@end
