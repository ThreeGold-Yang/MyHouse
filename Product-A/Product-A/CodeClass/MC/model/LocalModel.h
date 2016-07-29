//
//  LocalModel.h
//  Product-A
//
//  Created by lanou on 16/7/4.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalModel : NSObject
@property(nonatomic,strong) NSString *musicTitle;
@property(nonatomic,strong) NSString *musicUrl;
@property(nonatomic,strong) NSString *musicImageUrl;
@property(nonatomic,strong) NSString *musicPath;
@property(nonatomic,assign) BOOL isthere;


+(LocalModel *)localModelWithSQLArr:(NSMutableArray *)SQLArr;

+(NSMutableArray *)modelWithSQLArr:(NSMutableArray *)SQLArr;

@end
