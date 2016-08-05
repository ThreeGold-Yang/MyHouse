//
//  MyPlayerManager.h
//  MyAVPlayer
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
// 播放模式
typedef NS_ENUM(NSInteger,PlayType)
{
    SignlePlay, // 单曲
    RandomPlay, // 随机
    ListPlay    // 列表
};
// 播放状态
typedef NS_ENUM(NSInteger,PlayState)
{
    Play,
    Pause
};
@interface MyPlayerManager : NSObject

@property(nonatomic,assign) PlayType playType;
@property(nonatomic,assign) PlayState playState;
@property(nonatomic,strong) AVPlayer *avPlayer;
// 装载music
@property(nonatomic,strong) NSMutableArray *musicLists;
// 索引
@property(nonatomic,assign) NSInteger index;
// 时长
@property(nonatomic,assign) float currentTime;
@property(nonatomic,assign) float totalTime;

+(MyPlayerManager *)defaultManager;
-(instancetype)init;
// 设置数据
-(void)setMusicLists:(NSMutableArray *)musicLists;
// 播放
-(void)play;
// 暂停
-(void)pause;
// 停止
-(void)stop;
// 改变当前播放源的时间
-(void)seekToSecondsWith:(float)seconds;
// 当前时间
-(float)currentTime;
// 总时间
-(float)totalTime;
// 上一首
-(void)lastMusic;
// 下一首
-(void)nextMusic;
// 根据index 来切换item
-(void)changeMusicWithIndex:(NSInteger)index;
// 自动调换切歌
-(void)playerDidFinish;
@end

