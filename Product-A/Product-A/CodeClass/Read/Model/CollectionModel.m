//
//  CollectionModel.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConWithJSDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArray = dataDic[@"list"];
    for (NSDictionary *dic in listArray) {
        CollectionModel *collectionModel = [[CollectionModel alloc]init];
        [collectionModel setValuesForKeysWithDictionary:dic];
        [arr addObject:collectionModel];
    }
    return arr;
}
@end
