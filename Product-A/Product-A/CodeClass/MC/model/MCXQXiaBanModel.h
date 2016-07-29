//
//  MCXQXiaBanModel.h
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger ,DownType)
{
    noDown,
    susDowning,
    startDowning,
    diDown,
};

@interface MCXQXiaBanModel : NSObject
@property(nonatomic,strong) NSString *coverimg;
@property(nonatomic,strong) NSString *musicUrl;
@property(nonatomic,strong) NSString *musicVisit;
@property(nonatomic,strong) NSString *tingid;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *webview_url;
@property(nonatomic,strong) NSString *uname;

@property(nonatomic,assign) DownType downType;
@property(nonatomic,assign) BOOL thereIs;


+(NSMutableArray *)mcXQxiaBanModelListWithJSONDic:(NSDictionary *)jsonDic;
@end
