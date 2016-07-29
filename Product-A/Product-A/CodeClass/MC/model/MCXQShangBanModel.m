//
//  MCXQShangBanModel.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCXQShangBanModel.h"

@implementation MCXQShangBanModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


+(NSMutableArray *)mcXQShangBanModelWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSDictionary *radioInfoDic = dataDic[@"radioInfo"];
    
    MCXQShangBanModel *model = [[MCXQShangBanModel alloc]init];
    model.coverimg = radioInfoDic[@"coverimg"];
    model.desc = radioInfoDic[@"desc"];
    model.musicvisitnum = radioInfoDic[@"musicvisitnum"];
    model.radioid = radioInfoDic[@"radioid"];
    model.title = radioInfoDic[@"title"];
    NSDictionary *userinfoDic = radioInfoDic[@"userinfo"];
    model.icon = userinfoDic[@"icon"];
    model.uid = userinfoDic[@"uid"];
    model.uname = userinfoDic[@"uname"];
    [arr addObject:model];
    
    return arr;
}
@end
