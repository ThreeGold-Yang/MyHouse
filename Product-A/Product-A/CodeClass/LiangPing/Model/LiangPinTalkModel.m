//
//  LiangPinTalkModel.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPinTalkModel.h"

@implementation LiangPinTalkModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *commentlistArr = dataDic[@"commentlist"];
    for (NSDictionary *dic in commentlistArr) {
        LiangPinTalkModel *model = [[LiangPinTalkModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *userinfoDic = dic[@"userinfo"];
        model.icon = userinfoDic[@"icon"];
        model.uid = userinfoDic[@"uid"];
        model.uname = userinfoDic[@"uname"];
        [arr addObject:model];
    }
    return arr;
}






@end
