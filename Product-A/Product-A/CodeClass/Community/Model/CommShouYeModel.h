//
//  CommShouYeModel.h
//  Product-A
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommShouYeModel : NSObject
@property(nonatomic,strong) NSString *addtime;
@property(nonatomic,strong) NSString *addtime_f;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *contentid;
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) NSString *comment;
@property(nonatomic,strong) NSString *like;
@property(nonatomic,strong) NSString *view;

@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;



+(NSMutableArray *)modelWith:(NSDictionary *)jsonDic;
@end
