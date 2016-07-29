//
//  CommShouYeModel.m
//  Product-A
//
//  Created by lanou on 16/7/5.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommShouYeModel.h"

@implementation CommShouYeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelWith:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr) {
        CommShouYeModel *model = [[CommShouYeModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        
        NSDictionary *counterListDic = dic[@"counterList"];
        model.comment = counterListDic[@"comment"];
        model.like = counterListDic[@"like"];
        model.view = counterListDic[@"view"];
        
        NSDictionary *userinfoDic = dic[@"userinfo"];
        model.icon = userinfoDic[@"icon"];
        model.uid = userinfoDic[@"uid"];
        model.uname = userinfoDic[@"uname"];
        
        [arr addObject:model];
    }
    return arr;
}















@end
