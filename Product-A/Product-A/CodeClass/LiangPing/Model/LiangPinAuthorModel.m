//
//  LiangPinAuthorModel.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPinAuthorModel.h"

@implementation LiangPinAuthorModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
{
    NSMutableArray *arr = [NSMutableArray array];
    LiangPinAuthorModel *model = [[LiangPinAuthorModel alloc]init];
    NSDictionary *dataDic = jsonDic[@"data"];
    
    NSDictionary *postsinfoDic = dataDic[@"postsinfo"];
    model.addtime = postsinfoDic[@"addtime"];
    model.addtime_f = postsinfoDic[@"addtime_f"];
    model.contentid = postsinfoDic[@"contentid"];
    NSDictionary *counterListDic = postsinfoDic[@"counterList"];
    model.comment = counterListDic[@"comment"];
    model.like = counterListDic[@"like"];
    model.view = counterListDic[@"view"];
    NSDictionary *groupInfoDic = postsinfoDic[@"groupInfo"];
    model.groupid = groupInfoDic[@"groupid"];
    model.groupTitle = groupInfoDic[@"title"];
    NSArray *imglistArr = postsinfoDic[@"imglist"];
    for (NSDictionary *dic in imglistArr) {
        [model setValuesForKeysWithDictionary:dic];
    }
    NSDictionary *shareinfoDic = postsinfoDic[@"shareinfo"];
    model.pic = shareinfoDic[@"pic"];
    model.text = shareinfoDic[@"text"];
    model.shareTitle = shareinfoDic[@"title"];
    model.url = shareinfoDic[@"url"];
    
    model.title = postsinfoDic[@"title"];
    
    NSDictionary *userinfoDic = postsinfoDic[@"userinfo"];
    model.icon = userinfoDic[@"icon"];
    model.uid = userinfoDic[@"uid"];
    model.uname = userinfoDic[@"uname"];
    
    [arr addObject:model];
    
    return arr;
    
}









@end
