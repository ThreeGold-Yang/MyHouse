//
//  VideoManager.m
//  UIAdvanced_VideoPlayer
//
//  Created by lanou on 16/6/8.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "VideoManager.h"

@implementation VideoManager


+(VideoManager *)shareInstance;
{
    static VideoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VideoManager alloc]init];
    });
    return manager;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.player = [[AVPlayer alloc]init];
    }
    return self;
}

-(void)switchItemWithUrlString:(NSString *)urlString
{
    AVPlayerItem *item = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:urlString]];
    [self.player replaceCurrentItemWithPlayerItem:item];
    [self startPlay];
}

//本地
-(void)localItemWithPath:(NSString *)path
{
    NSURL *localUrl = [NSURL fileURLWithPath:path];
    AVAsset *localSet = [AVURLAsset URLAssetWithURL:localUrl options:nil];
    AVPlayerItem *localItem = [[AVPlayerItem alloc]initWithAsset:localSet];
    [self.player replaceCurrentItemWithPlayerItem:localItem];
    [self startPlay];
}



-(void)startPlay
{
    [self.player play];
    self.isPlay = YES;
}

-(void)endPlay
{
    [self.player pause];
    self.isPlay = NO;
}

-(void)endOrStartPlay;
{
    if (self.isPlay == YES) {
        [self endPlay];
    }
    else
    {
        [self startPlay];
    }
}

-(void)autoPlay;
{
    if (self.playState == ordinaryPlay) {
        if (self.index == self.Array.count - 1) {
            self.index = 0;
        }
        else
        {
            self.index ++;
        }
    }
    if (self.playState == singlePlay) {
        
    }
    if (self.playState == randomPlay) {
        self.index = arc4random()% self.Array.count;
    }
}

-(void)ctrolVolumeWithVolumeFloat:(CGFloat)volume;
{
    self.player.volume = volume;
}

-(void)ctrolVolumeWithProgressFloat:(CGFloat)progress;
{
    [self.player  seekToTime:CMTimeMakeWithSeconds(progress, 1) completionHandler:^(BOOL finished) {
    [self startPlay];
    }];
}

-(void)nextVideo;
{
    if (self.playState == randomPlay) {
        self.index = arc4random()% self.Array.count;
    }
    else if (self.playState == singlePlay){
        
    }
    else if (self.playState == ordinaryPlay)
    {
        if (self.index == self.Array.count-1) {
            self.index = 0;
        }
        else
        {
            self.index ++;
        }
    }
}

-(void)topVideo;
{
    if (self.playState == randomPlay){
        self.index = arc4random()% self.Array.count;
    }
    
    else if (self.playState == singlePlay){
        
    }
    
    else if (self.playState == ordinaryPlay){
        if (self.index == 0)
        {
            self.index = self.Array.count - 1;
        }
        else
        {
            self.index --;
        }
    }
    
}

-(void)randomPlay;
{
    self.playState = randomPlay;
    self.index = arc4random() % self.Array.count;
}

-(void)singlePlay;
{
    self.playState = singlePlay;
    NSInteger index = self.index;
    self.index = index;
}
















@end
