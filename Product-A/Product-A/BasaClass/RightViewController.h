//
//  RightViewController.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,MoveType)
{
    MoveTypeLeft,
    MoveTypeRight
};


@interface RightViewController : UIViewController

@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *button;
// 隐藏rootVC 或者 显示rootVC
-(void)ChangeFrameWithType:(MoveType)tpe;

@end
