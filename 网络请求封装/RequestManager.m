//
//  RequestManager.m
//  UI02GETTequest2
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+(void)requestWithUrlString:(NSString *)urlString finish:(Finish)finish error:(Error)error requestType:(RequestType)requestType parDic:(NSDictionary *)parDic;
{
    
    RequestManager *request = [[RequestManager alloc]init];
    
    [request requestWithUrlString:urlString finish:finish error:error requestType:requestType parDic:parDic];
    
}

-(void)requestWithUrlString:(NSString *)urlString finish:(Finish)finish error:(Error)error requestType:(RequestType)requestType parDic:(NSDictionary *)parDic;
{
    // 对block属性赋值
    self.finish = finish;
    self.error  = error;
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    
    if (requestType == RequestPOST)
    {
        [request setHTTPMethod:@"POST"];
        if (parDic.count > 0) // 此判断加强了安全性
        {
            // 设置请求体
            [request setHTTPBody:[self parDicToPOSTData:parDic]];
        }
    }

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        if(error)
        {
            self.error(error);
        }
        else
        {
            dispatch_sync(dispatch_get_main_queue(),^{
            self.finish(data);//  这个data 是已经有完整数据的 data
            });
        }
    }];
    [task resume];//  异步网络链接
    
}

    
-(NSData *)parDicToPOSTData:(NSDictionary *)parDic
{
    // 用一个数组将每一对 键值对放入数组
    NSMutableArray *array = [NSMutableArray array];
    
    // 遍历字典，将每一对键值对用=号连接
    for (NSString *key in parDic) {
        NSString *string = [NSString stringWithFormat:@"%@=%@",key,parDic[key]];
        
        [array addObject:string];
        
      //  NSLog(@"%@",array);
    }
    
    // 将每一对用 &连接
    NSString *poststring = [array componentsJoinedByString:@"&"];
    
    // 并转化成 data
    NSData *postdata = [poststring dataUsingEncoding:NSUTF8StringEncoding];
    return postdata;
}






@end
