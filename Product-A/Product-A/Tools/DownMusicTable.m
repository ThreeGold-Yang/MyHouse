//
//  DownMusicTable.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "DownMusicTable.h"

@implementation DownMusicTable

-(instancetype)init
{
    self = [super init];
    if (self) {
        _dataBase = [DBManager shareInstance].dataBase;
    }
    return self;
}


// 创建表
-(void)creatTable;
{
    // 判断是否已经有了该表格
    NSString *query = [NSString stringWithFormat:@"select count(*) from sqlite_master where type = 'table' and name = '%@'",KDownMusicTableName];
    FMResultSet *set = [_dataBase executeQuery:query];
    [set next];
    int count = [set intForColumnIndex:0];
    BOOL exist = count;
    if (exist) {
        NSLog(@"%@表存在",KDownMusicTableName);
    }else{
        NSLog(@"不存在");
    }
    
    // 创建表。。
    NSString *update = [NSString stringWithFormat:@"create table %@(musicID  INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL,title text,musicUrl text,musicImage text,musicPath text)",KDownMusicTableName];
    BOOL result = [_dataBase executeUpdate:update]; // 关键
    if (result) {
        NSLog(@"%@表创建成功",KDownMusicTableName);
    }else{
        NSLog(@"%@表创建失败",KDownMusicTableName);
    }
    
    
}
// 插入
-(void)insetIntoTable:(NSArray *)Info;
{
    NSString *update = [NSString stringWithFormat:@"INSERT INTO %@ (title,musicUrl,musicImage,musicPath ) values(?,?,?,?)",KDownMusicTableName];
    BOOL result = [_dataBase executeUpdate:update withArgumentsInArray:Info]; // 关键
    if (result) {
        NSLog(@"%@表插入成功",KDownMusicTableName);
    }else{
        NSLog(@"%@表插入失败",KDownMusicTableName);
    }

}
// 取出
-(NSMutableArray *)selectAll;
{
    NSString *update = [NSString stringWithFormat:@"select *from %@",KDownMusicTableName];
    FMResultSet *set = [_dataBase executeQuery:update]; // 关键
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[set columnCount]];
    while ([set next]) {
       NSString *title = [set stringForColumn:@"title"];
        NSString *musicUrl = [set stringForColumn:@"musicUrl"];
        NSString *musicImage = [set stringForColumn:@"musicImage"];
        NSString *musicPath = [set stringForColumn:@"musicPath"];
        
        [array addObject:@[title,musicUrl,musicImage,musicPath]];
    }
    return array;
}
@end
