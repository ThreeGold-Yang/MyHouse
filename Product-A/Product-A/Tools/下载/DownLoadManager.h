//
//  DownLoadManager.h
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownLoad.h"
@interface DownLoadManager : NSObject




+(DownLoadManager *)shareInstance;

// 创建一个下载任务
-(DownLoad *)creatDownload:(NSString *)url;





@end
