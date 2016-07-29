//
//  CollectionModel.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *enname;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) NSInteger type;

+(NSMutableArray *)modelConWithJSDic:(NSDictionary *)jsonDic;

@end
