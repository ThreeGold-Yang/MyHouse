//
//  DownLoadManager.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "DownLoadManager.h"
static DownLoadManager *manager = nil;

@interface DownLoadManager ()<DownloadDelegate>

@property(nonatomic,strong) NSMutableDictionary *dic; // 存放下载任务

@end

@implementation DownLoadManager

-(NSMutableDictionary *)dic
{
    if (!_dic) {
        _dic = [[NSMutableDictionary alloc]init];
    }
    return _dic;
}

+(DownLoadManager *)shareInstance;
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownLoadManager alloc]init];
    });
    return manager;
}



// 创建一个下载任务
-(DownLoad *)creatDownload:(NSString *)url;
{
    DownLoad *task = self.dic[url];
    if (!task) {
        task = [[DownLoad  alloc]initWith:url];
        [self.dic setValue:task forKey:url];
    }
    task.delegate = self;
    return task;
}

-(void)removeDownloadTask:(NSString *)url;
{
    [self.dic removeObjectForKey:url];
}


@end
