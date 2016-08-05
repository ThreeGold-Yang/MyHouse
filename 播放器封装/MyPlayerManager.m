//
//  MyPlayerManager.m
//  MyAVPlayer
//
//  Created by lanou on 16/6/28.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//


#import "MyPlayerManager.h"


@implementation MyPlayerManager

+(MyPlayerManager *)defaultManager
{
    static MyPlayerManager *myPlayerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myPlayerManager = [[MyPlayerManager alloc]init];
    });
    return myPlayerManager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.playState = Pause;
        self.playType = ListPlay;
    }
    return self;
}
// 设置数据
-(void)setMusicLists:(NSMutableArray *)musicLists
{
    [self.musicLists removeAllObjects];
    self.musicLists = [musicLists mutableCopy];
    AVPlayerItem *avPlayerItem = [AVPlayerItem playerItemWithURL:self.musicLists[self.index]];
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    }
    else
    {
        // 替换 item
        [self.avPlayer replaceCurrentItemWithPlayerItem:avPlayerItem];
    }
}

// 播放
-(void)play
{
    [self.avPlayer play];
    self.playState = Play;
}

// 暂停
-(void)pause
{
    [self.avPlayer pause];
    self.playState = Pause;
}

// 停止
-(void)stop
{
    [self  seekToSecondsWith:0];
    self.playState = Pause;
}
// 改变当前播放源的时间
-(void)seekToSecondsWith:(float)seconds
{
    CMTime newTime = self.avPlayer.currentTime;
    newTime.value = newTime.timescale * seconds;
    [self.avPlayer seekToTime:newTime];
}

#pragma mark --- 时间获取 ---
// 当前时间
-(float)currentTime
{
    if (self.avPlayer.currentTime.timescale == 0) {
        return 0;
    }
    return self.avPlayer.currentTime.value / self.avPlayer.currentTime.timescale;
}
// 总时间
-(float)totalTime
{
    if (self.avPlayer.currentItem.duration.timescale == 0) {
        return 0;
    }
    return self.avPlayer.currentItem.duration.value / self.avPlayer.currentItem.duration.timescale;
}


// 上一首
-(void)lastMusic
{
    if (self.playType == RandomPlay) {
        self.index = arc4random()% self.musicLists.count;
    }
    else
    {
        if (self.index == 0) {
            self.index = self.musicLists.count -1;
        }
        else
        {
            self.index --;
        }
    }
}

// 下一首
-(void)nextMusic
{
    
    if (self.playType == RandomPlay) {
        self.index = arc4random()% self.musicLists.count;
    }
    else
    {
        if (self.index == self.
            musicLists.count - 1) {
            self.index = 0;
        }
        self.index ++;
    }
}
// 根据index 来切换item
-(void)changeMusicWithIndex:(NSInteger)index
{
    self.index = index;
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:self.musicLists[index]]];
    [self.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [self play];
}
// 自动调换切歌
-(void)playerDidFinish
{
    if (self.playType == SignlePlay) {
        [self pause];
    }
    else
    {
        [self nextMusic];
    }
}
















@end
