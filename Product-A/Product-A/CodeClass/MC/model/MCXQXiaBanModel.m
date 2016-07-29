//
//  MCXQXiaBanModel.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCXQXiaBanModel.h"

@implementation MCXQXiaBanModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)mcXQxiaBanModelListWithJSONDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    NSArray *listArr = dataDic[@"list"];
    for (NSDictionary *dic in listArr)
    {
        MCXQXiaBanModel *model = [[MCXQXiaBanModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        NSDictionary *playinfoDic = dic[@"playInfo"];
        model.webview_url = playinfoDic[@"webview_url"];
        NSDictionary *userinfoDic = playinfoDic[@"userinfo"];
        model.uname = userinfoDic[@"uname"];
        model.downType = noDown;
        DownMusicTable *table = [[DownMusicTable alloc]init];
        NSArray *locaArr = [table selectAll];
        for (NSArray *localModelArr in locaArr) {
            if ([localModelArr containsObject:model.musicUrl])
            {
                model.downType = diDown;
            }
        }
        [arr addObject:model];
    }
        
    
    return arr;
}


@end
