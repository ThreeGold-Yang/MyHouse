//
//  RequestManager.m
//  UIAdvanced_MyOneProject
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//





#import "RequestManager.h"

@implementation RequestManager

+(void)requestDataWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    RequestManager *manager = [[RequestManager alloc]init];
    [manager requestDataWithUrlString:urlString parDic:parDic finish:finish error:error];
}

-(void)requestDataWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    self.finish = finish;
    self.error = error;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self backMainThred:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error(error);
    }];
}

-(void)backMainThred:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}













@end
