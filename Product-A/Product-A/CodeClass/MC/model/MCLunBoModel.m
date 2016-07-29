//
//  MCLunBoModel.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCLunBoModel.h"

@implementation MCLunBoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)mcLunBomodelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *carouselArr = dataDic[@"carousel"];
    for (NSDictionary *dic in carouselArr) {
        MCLunBoModel *model = [[MCLunBoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [array addObject:model];
    }
    return array;
}
@end
