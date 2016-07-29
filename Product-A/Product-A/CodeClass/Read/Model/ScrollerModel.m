//
//  ScrollerModel.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ScrollerModel.h"

@implementation ScrollerModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConWithJSDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *carouselArray = dataDic[@"carousel"];
    for (NSDictionary *dic in carouselArray) {
        ScrollerModel *scrollerModel = [[ScrollerModel alloc]init];
        [scrollerModel setValuesForKeysWithDictionary:dic];
        [arr addObject:scrollerModel];
    }
    return arr;
}


@end
