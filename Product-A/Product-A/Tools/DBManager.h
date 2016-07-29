//
//  DBManager.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
@property(nonatomic,strong) FMDatabase *dataBase;




+(DBManager *)shareInstance;

// 关闭数据库
-(void)close;

@end
