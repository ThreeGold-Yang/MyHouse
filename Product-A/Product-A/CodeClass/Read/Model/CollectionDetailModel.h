//
//  CollectionDetailModel.h
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionDetailModel : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *myID;
+(NSMutableArray *)modelConWithJsonDic:(NSDictionary *)jsonDic;
@end
