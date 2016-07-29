//
//  ScrollerModel.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollerModel : NSObject

@property(nonatomic,strong) NSString *img;
@property(nonatomic,strong) NSString *url;


+(NSMutableArray *)modelConWithJSDic:(NSDictionary *)jsonDic;
@end
