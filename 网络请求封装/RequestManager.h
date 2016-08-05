//
//  RequestManager.h
//  UI02GETTequest2
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求数据成功之后进行回调，返回NSData
typedef void(^Finish) (NSData *data);
// 请求数据失败之后进行回调，返回NSError
typedef void(^Error) (NSError *error);


// 请求方式的枚举
typedef NS_ENUM(NSInteger,RequestType) {
    RequestGET,
    RequestPOST
};


@interface RequestManager : NSObject
@property(nonatomic,copy) Finish finish;
@property(nonatomic,copy) Error error;

+(void)requestWithUrlString:(NSString *)urlString finish:(Finish)finish error:(Error)error requestType:(RequestType)requestType parDic:(NSDictionary *)parDic;



@end
