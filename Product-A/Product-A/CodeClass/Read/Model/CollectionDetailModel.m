//
//  CollectionDetailModel.m
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CollectionDetailModel.h"

@implementation CollectionDetailModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        CollectionDetailModel *collectionDetailModel = [[CollectionDetailModel alloc]init];
        [collectionDetailModel setValuesForKeysWithDictionary:dic];
        collectionDetailModel.myID = dic[@"id"];
        [arr addObject:collectionDetailModel];
    }
    return arr;
}

@end
