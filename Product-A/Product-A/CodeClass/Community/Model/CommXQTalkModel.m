//
//  CommXQTalkModel.m
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommXQTalkModel.h"

@implementation CommXQTalkModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)modelWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *commentlistArr = dataDic[@"commentlist"];
    for (NSDictionary *dic in commentlistArr) {
        CommXQTalkModel *model = [[CommXQTalkModel alloc]init];
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
