//
//  AFNetRequestManager.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "AFNetRequestManager.h"

@implementation AFNetRequestManager

+(void)requestDataWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    AFNetRequestManager *manager = [[AFNetRequestManager alloc]init];
    [manager requestDataWithURLString:urlString parDic:parDic finish:finish error:error];
}

-(void)requestDataWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;
{
    self.finish = finish;
    self.error = error;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self backMainThread:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error===%@",error);
    }];
}

-(void)backMainThread:(NSData *)data
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.finish(data);
    });
}

@end
