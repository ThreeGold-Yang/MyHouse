//
//  DownMusicTable.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@interface DownMusicTable : NSObject

@property(nonatomic,strong) FMDatabase *dataBase;

// 创建表
-(void)creatTable;
// 插入
-(void)insetIntoTable:(NSArray *)Info;
// 取出
-(NSMutableArray *)selectAll;


@end
