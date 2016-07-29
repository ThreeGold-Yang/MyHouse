//
//  AFNetRequestManager.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Finish)(NSData *data);
typedef void (^Error)(NSError *error);
@interface AFNetRequestManager : NSObject

@property(nonatomic,copy) Finish finish;
@property(nonatomic,copy) Error error;


+(void)requestDataWithURLString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;

@end
