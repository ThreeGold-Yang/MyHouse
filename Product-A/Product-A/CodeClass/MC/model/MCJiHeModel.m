//
//  MCJiHeModel.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCJiHeModel.h"

@implementation MCJiHeModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)mcJiHemodelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *hotlistArr = dataDic[@"hotlist"];
    for (NSDictionary *dic in hotlistArr) {
        MCJiHeModel *model = [[MCJiHeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [arr addObject:model];
    }
    return arr;
}
@end
