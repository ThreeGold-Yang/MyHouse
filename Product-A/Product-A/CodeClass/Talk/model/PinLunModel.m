//
//  PinLunModel.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "PinLunModel.h"

@implementation PinLunModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConWithJSDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        PinLunModel *model = [[PinLunModel alloc]init];
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
