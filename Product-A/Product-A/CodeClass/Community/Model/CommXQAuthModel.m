//
//  CommXQAuthModel.m
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommXQAuthModel.h"

@implementation CommXQAuthModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+(CommXQAuthModel *)modelWithJsonDic:(NSDictionary *)jsonDic
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *dataDic = jsonDic[@"data"];
    CommXQAuthModel *model = [[CommXQAuthModel alloc]init];
    NSDictionary *postsinfoDic = dataDic[@"postsinfo"];
    model.addtime = postsinfoDic[@"addtime"];
    model.addtime_f = postsinfoDic[@"addtime_f"];
    model.contentid = postsinfoDic[@"contentid"];
    model.songid = postsinfoDic[@"songid"];
    model.title = postsinfoDic[@"title"];
    
    NSDictionary *counterListDic = postsinfoDic[@"counterList"];
    model.comment = counterListDic[@"comment"];
    model.like = counterListDic[@"like"];
    model.view = counterListDic[@"view"];
    
    NSDictionary *groupInfoDic = postsinfoDic[@"groupInfo"];
    model.groupid = groupInfoDic[@"groupid"];
    model.grouptitle = groupInfoDic[@"title"];
    
    NSDictionary *shareinfoDic = postsinfoDic[@"shareinfo"];
    model.pic = shareinfoDic[@"pic"];
    model.text = shareinfoDic[@"text"];
    model.shareTitle = shareinfoDic[@"title"];
    model.url = shareinfoDic[@"url"];
    
    NSDictionary *userinfoDic = postsinfoDic[@"userinfo"];
    model.icon = userinfoDic[@"icon"];
    model.uid = userinfoDic[@"uid"];
    model.uname = userinfoDic[@"uname"];
    
    
    return model;
}






@end
