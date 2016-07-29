//
//  CommXQTalkModel.h
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommXQTalkModel : NSObject

@property(nonatomic,strong) NSString *addtime_f;
@property(nonatomic,strong) NSString *cmtnum;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *contentid;
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *likenum;
 // userinfo
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;



+(NSMutableArray *)modelWithJsonDic:(NSDictionary *)jsonDic;

@end
