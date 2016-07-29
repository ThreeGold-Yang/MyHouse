//
//  MCBiaoModel.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCBiaoModel.h"

@implementation MCBiaoModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)mcBiaoModelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"alllist"];
    for (NSDictionary *dic in listArr) {
        MCBiaoModel *model = [[MCBiaoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *userinfoDic = dic[@"userinfo"];
        model.uname = userinfoDic[@"uname"];
        model.icon = userinfoDic[@"icon"];
        model.uid = [NSString stringWithFormat:@"%@",userinfoDic[@"uid"]];
        [arr addObject:model];
    }
    return arr;
}
@end
