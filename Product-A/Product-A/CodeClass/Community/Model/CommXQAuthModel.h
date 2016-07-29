//
//  CommXQAuthModel.h
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommXQAuthModel : NSObject

// 文章区
@property(nonatomic,strong) NSString *addtime;
@property(nonatomic,strong) NSString *addtime_f;
@property(nonatomic,strong) NSString *contentid;
@property(nonatomic,strong) NSString *songid;
@property(nonatomic,strong) NSString *title;
// counterList
@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) NSString *like;
@property(nonatomic,strong) NSString *view;
// group
@property(nonatomic,strong) NSString *groupid;
@property(nonatomic,strong) NSString *grouptitle;
// shareinfo
@property(nonatomic,strong) NSString *pic;
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) NSString *shareTitle;
@property(nonatomic,strong) NSString *url;
// userinfo
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;


+(CommXQAuthModel *)modelWithJsonDic:(NSDictionary *)jsonDic;


@end

