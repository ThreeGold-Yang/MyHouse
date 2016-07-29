//
//  LocalModel.m
//  Product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LocalModel.h"

@implementation LocalModel

+(LocalModel *)localModelWithSQLArr:(NSMutableArray *)SQLArr
{
    LocalModel *model = [[LocalModel alloc]init];
    model.musicTitle = SQLArr[0];
    model.musicUrl = SQLArr[1];
    model.musicImageUrl = SQLArr[2];
    model.musicPath = SQLArr[3];
    return model;
    
}

+(NSMutableArray *)modelWithSQLArr:(NSMutableArray *)SQLArr;
{
    NSMutableArray *arr = [NSMutableArray array];
    LocalModel *model = [[LocalModel alloc]init];
    model.musicTitle = SQLArr[0];
    model.musicUrl = SQLArr[1];
    model.musicImageUrl = SQLArr[2];
    model.musicPath = SQLArr[3];
    
    [arr addObject:model];
    return arr;
}
@end
