//
//  VideoManager.h
//  UIAdvanced_VideoPlayer
//
//  Created by lanou on 16/6/8.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MCXQXiaBanModel.h"
#import "LocalModel.h"
typedef NS_ENUM(NSInteger,PlayState)
{
    ordinaryPlay,
    randomPlay,
    singlePlay
};

typedef void(^PassXiaModel) (MCXQXiaBanModel *model);
typedef void (^LocalModelPass)(LocalModel *localModel);
@interface VideoManager : NSObject

@property(nonatomic,strong) NSMutableArray *Array;

@property(nonatomic,strong) NSString *ss;

@property(nonatomic,assign) NSInteger index;

@property(nonatomic,strong) AVPlayer *player;

@property(nonatomic,assign) BOOL isPlay;

@property(nonatomic,assign) PlayState playState;

@property(nonatomic,copy) PassXiaModel passXiaModel;
@property(nonatomic,copy) LocalModelPass localModelPass;

+(VideoManager *)shareInstance;

-(void)startPlay;

-(void)endPlay;

-(void)autoPlay;

-(void)endOrStartPlay;

-(void)switchItemWithUrlString:(NSString *)urlString;

//本地
-(void)localItemWithPath:(NSString *)path;

-(void)ctrolVolumeWithVolumeFloat:(CGFloat)volume;

-(void)ctrolVolumeWithProgressFloat:(CGFloat)progress;

-(void)nextVideo;

-(void)topVideo;

-(void)randomPlay;

-(void)singlePlay;




@end
