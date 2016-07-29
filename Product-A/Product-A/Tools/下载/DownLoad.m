//
//  DownLoad.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "DownLoad.h"
@interface DownLoad ()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong)NSURLSessionDownloadTask *downLoadTask;
@property(nonatomic,copy)Downloading downloading;
@property(nonatomic,copy)DidDownload didDownload;
@end

@implementation DownLoad
-(void)dealloc
{
    _delegate = nil;
    NSLog(@"%s",__FUNCTION__);
}

// 给一个下载地址初始化
-(instancetype)initWith:(NSString *)url;
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        _downLoadTask = [session downloadTaskWithURL:[NSURL URLWithString:url]];
        _url = url;
    }
    return  self;
}

// 开始下载
-(void)startDown;
{
    [_downLoadTask resume];
}

// 暂停下载
-(void)suspendDown
{
    [_downLoadTask suspend];
}
#pragma mark =====下载代理=====
// 完成下载
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location;
{
    // caches路径
    NSString *cashesFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 拼接下载文件路径
    NSString *filePath = [cashesFilePath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    NSLog(@"文件路径------%@",downloadTask.response.suggestedFilename);
    
    // 将下载好的文件移到指定路径
    NSLog(@"原始保存路径----%@",location.path);
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm moveItemAtPath:location.path toPath:filePath error:nil];
    
    if (_didDownload) {
        _didDownload(filePath,_url);
    }
    if (_delegate && [_delegate respondsToSelector:@selector(removeDownloadTask:)]) {
        [_delegate removeDownloadTask:self.url];
    }
    // 关闭会话
    [session invalidateAndCancel];
}
// 下载中
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite;
{
    float progress = (float)totalBytesWritten / totalBytesExpectedToWrite; // 进度
    _progress = progress * 100;
    if (_downloading) {
        _downloading(bytesWritten,_progress); // 速度，进度
    }
    
}

// 监听下载的方法
-(void)monitorDownloading:(Downloading)downloading DidDownload:(DidDownload)didDownload;
{
    // 获得数据
    _downloading = downloading;
    _didDownload = didDownload;
}

@end
