//
//  RequestManager.h
//  UIAdvanced_MyOneProject
//
//  Created by lanou on 16/6/17.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//


typedef void(^Finish) (NSData *data);
typedef void(^Error) (NSError *error);

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject

@property(nonatomic,copy) Finish finish;
@property(nonatomic,copy) Error error;


+(void)requestDataWithUrlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(Finish)finish error:(Error)error;






@end
