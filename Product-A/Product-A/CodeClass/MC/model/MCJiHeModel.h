//
//  MCJiHeModel.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCJiHeModel : NSObject
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *radioid;

+(NSMutableArray *)mcJiHemodelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
