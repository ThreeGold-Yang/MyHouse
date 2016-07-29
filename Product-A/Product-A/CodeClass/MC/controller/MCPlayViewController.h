//
//  MCPlayViewController.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TopViewController.h"

@interface MCPlayViewController : TopViewController

@property(nonatomic,strong) NSMutableArray *musicUrlArr;
@property(nonatomic,strong) UIButton *playTypeBtn;

@property(nonatomic,strong) NSMutableArray *localArr;
@property(nonatomic,assign) NSInteger localIndex;

@end
