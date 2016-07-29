//
//  DownLoad.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^Downloading)(long long bytesWritten,NSInteger progress); // 下载中，返回瞬时速度和进度
typedef void (^DidDownload)(NSString *savePath,NSString *url);//下载完成，返回一个保存路径、下载地址(用作标识)

@protocol DownloadDelegate <NSObject>

-(void)removeDownloadTask:(NSString *)url;

@end

@interface DownLoad : NSObject
@property(nonatomic,strong) NSString *url;
@property(nonatomic,assign) NSInteger progress;
@property(nonatomic,assign) id <DownloadDelegate>delegate;




// 给一个下载地址初始化
-(instancetype)initWith:(NSString *)url;

// 开始下载
-(void)startDown;
// 暂停下载
-(void)suspendDown;
// 监听下载的方法
-(void)monitorDownloading:(Downloading)downloading DidDownload:(DidDownload)didDownload;





@end
