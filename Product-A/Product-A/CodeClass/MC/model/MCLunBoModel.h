//
//  MCLunBoModel.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCLunBoModel : NSObject

@property(nonatomic,strong) NSString *img;
@property(nonatomic,strong) NSString *url;

+(NSMutableArray *)mcLunBomodelConfigureWithJsonDic:(NSDictionary *)jsonDic;
@end
