//
//  LiangPinTalkModel.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiangPinTalkModel : NSObject
@property(nonatomic,strong) NSString *addtime_f;
@property(nonatomic,strong) NSString *cmtnum;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *contentid;
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;


+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
