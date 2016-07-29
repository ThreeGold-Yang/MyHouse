//
//  DBManager.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "DBManager.h"

static DBManager *manager = nil;
@interface DBManager ()
@property(nonatomic,strong) NSString *filePath;

@end
@implementation DBManager

+(DBManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DBManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化数据库 -->FMDB
        [self initDataBaseWith:KMySqliteName];
    };
    return self;
}
// 创建数据库
-(void)initDataBaseWith:(NSString *)name
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(9, 1, 1)lastObject];
    self.filePath = [documentPath stringByAppendingPathComponent:name];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:self.filePath];
    [self connect];
    if (exist) {
        NSLog(@"数据库：%@ 已经存在",name);
    }else{
        NSLog(@"数据库：%@ 不存在",name);
    }
}
// 链接数据库
-(void)connect
{
    if (!_dataBase) {
        _dataBase = [FMDatabase databaseWithPath:self.filePath];
    }
    if (![_dataBase open]) {
        NSLog(@"打开失败");
    }else{
        NSLog(@"成功打开");
    }
}

-(void)close
{
    [_dataBase close];
    manager = nil;
}

-(void)dealloc
{
    [self close];
}


@end
