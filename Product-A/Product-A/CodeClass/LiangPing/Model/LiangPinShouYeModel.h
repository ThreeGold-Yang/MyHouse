//
//  LiangPinShouYeModel.h
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiangPinShouYeModel : NSObject
@property(nonatomic,strong) NSString *buyurl;
@property(nonatomic,strong) NSString *contentid;
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *title;

+(NSMutableArray *)modelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
