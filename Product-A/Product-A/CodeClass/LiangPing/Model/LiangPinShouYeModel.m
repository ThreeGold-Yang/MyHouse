//
//  LiangPinShouYeModel.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPinShouYeModel.h"

@implementation LiangPinShouYeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        LiangPinShouYeModel *model = [[LiangPinShouYeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}

@end
