//
//  LiangPinAuthorModel.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiangPinAuthorModel : NSObject
@property(nonatomic,strong) NSString *addtime;
@property(nonatomic,strong) NSString *addtime_f;
@property(nonatomic,strong) NSString *contentid;

@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) NSString *like;
@property(nonatomic,strong) NSString *view;

@property(nonatomic,strong) NSString *groupid;
@property(nonatomic,strong) NSString *groupTitle;

@property(nonatomic,strong) NSString *imgurl;

@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *shareTitle;
@property(nonatomic,strong) NSString *url;

@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;


+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
