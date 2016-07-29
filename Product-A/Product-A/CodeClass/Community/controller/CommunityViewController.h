//
//  CommunityViewController.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RightViewController.h"

typedef NS_ENUM(NSInteger,RequestState)
{
    hotState,
    newState
};

@interface CommunityViewController : RightViewController

@property(nonatomic,assign) RequestState requestState;

@end
