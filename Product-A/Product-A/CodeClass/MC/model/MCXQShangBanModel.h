//
//  MCXQShangBanModel.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCXQShangBanModel : NSObject
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *desc;
@property(nonatomic,strong) NSString *musicvisitnum;
@property(nonatomic,strong) NSString *radioid;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *icon;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *uname;

+(NSMutableArray *)mcXQShangBanModelWithJsonDic:(NSDictionary *)jsonDic;
@end
