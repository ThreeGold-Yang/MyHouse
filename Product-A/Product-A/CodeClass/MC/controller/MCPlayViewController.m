//
//  MCPlayViewController.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCPlayViewController.h"
#import "MCXQXiaBanModel.h"
#import "MCPlayScr3TableViewCell.h"
#import "LocalModel.h"
#import "UINavigationController+WXSTransition.h"
#import "MCXiangQinViewController.h"

@interface MCPlayViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,DanmakuDelegate>

@property(nonatomic,strong) UIButton *mcPlayBackBtn;
@property(nonatomic,strong) UIButton *wujiaoxingBtn;
@property(nonatomic,strong) UIButton *xiejiantouBtn;
@property(nonatomic,strong) UIButton *naozhongBtn;

@property(nonatomic,strong) UIScrollView *mcPlayScrollerV;
@property(nonatomic,strong) UIImageView *backGroundImageV;
@property(nonatomic,strong) UIImageView *musicImageV;
@property(nonatomic,strong) UILabel *musicNameL;
@property(nonatomic,strong) UILabel *likeL;
@property(nonatomic,strong) UILabel *talkL;
@property(nonatomic,strong) UILabel *currentTimeL;
@property(nonatomic,strong) UISlider *progressSlider;
@property(nonatomic,strong) UILabel *allTimeL;
@property(nonatomic,strong) UIButton *dianjiBtn;



@property(nonatomic,strong) UIPageControl *page;
@property(nonatomic,strong) UIButton *shangBtn;
@property(nonatomic,strong) UIButton *zhongBtn;
@property(nonatomic,strong) UIButton *xiaBtn;

@property(nonatomic,strong) UIWebView *scr2;
@property(nonatomic,strong) UITableView *scr3;

@property(nonatomic,strong) NSTimer *timer;
@property(nonatomic,strong) CABasicAnimation *cabmation;


@property(nonatomic,strong) DanmakuView *danmuV;



@end

@implementation MCPlayViewController

-(NSMutableArray *)musicUrlArr
{
    if (!_musicUrlArr) {
        _musicUrlArr = [NSMutableArray array];
    }
    return _musicUrlArr;
}

-(NSMutableArray *)localArr
{
    if (!_localArr) {
        _localArr = [NSMutableArray array];
    }
    return _localArr;
}

-(CABasicAnimation *)cabmation
{
    if (!_cabmation) {
        _cabmation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        _cabmation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        _cabmation.duration = 5;
        _cabmation.repeatCount = FLT_MAX;
    }
    return _cabmation;
}
#pragma mark ==== 播放器ViewDidLoad ====

-(void)viewWillAppear:(BOOL)animated
{
    [self.musicImageV.layer addAnimation:self.cabmation forKey:nil];
    if ([VideoManager shareInstance].isPlay == YES) {
        [self.musicImageV.layer resumeAnimate];
    }else{
        [self.musicImageV.layer pauseAnimate];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatScrollerView];
    [self creatTopView];
    
    if (self.localArr.count == 0) {
        [self networkBroadcastWith:[VideoManager shareInstance].index];
    }else
    {
        [self localWorkBroadcastWith:self.localIndex];
    }

    [self creatDownView];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }

#pragma mark ==== 播放器方法 ====

-(void)creatTopView
{
    
    self.mcPlayBackBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.mcPlayBackBtn.frame = CGRectMake(0, 20, 40, 40);
    [self.mcPlayBackBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
    [self.mcPlayBackBtn addTarget:self action:@selector(mcPlayBackBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.mcPlayBackBtn];
    
    CGFloat jianju = (kScreenWidth - 200) / 5;
    self.playTypeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.playTypeBtn.frame = CGRectMake(40+jianju, 30, 40, 20);

    if ([VideoManager shareInstance].playState == ordinaryPlay) {
        [self.playTypeBtn setTitle:@"普通" forState:(UIControlStateNormal)];
    }
    if ([VideoManager shareInstance].playState == randomPlay) {
        [self.playTypeBtn setTitle:@"随机" forState:(UIControlStateNormal)];
    }
    if ([VideoManager shareInstance].playState == singlePlay) {
        [self.playTypeBtn setTitle:@"单曲" forState:(UIControlStateNormal)];
    }
    
    [self.playTypeBtn addTarget:self action:@selector(cutPlayTpe) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.playTypeBtn];
    
    self.wujiaoxingBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.wujiaoxingBtn.frame = CGRectMake(2*(jianju+40), 30, 40, 20);
    [self.wujiaoxingBtn setImage:[UIImage imageNamed:@"wujiaoxing"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.wujiaoxingBtn];
    
    self.xiejiantouBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.xiejiantouBtn.frame = CGRectMake(3*(jianju+40), 30, 40, 20);
    [self.xiejiantouBtn setImage:[UIImage imageNamed:@"xiejiantou"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.xiejiantouBtn];
    
    self.naozhongBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.naozhongBtn.frame = CGRectMake(4*(jianju+40), 30, 40, 20);
    [self.naozhongBtn setImage:[UIImage imageNamed:@"naozhong"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.naozhongBtn];
}

-(void)creatScrollerView
{
    self.mcPlayScrollerV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-144)];
    self.mcPlayScrollerV.contentSize = CGSizeMake(3*kScreenWidth, 0);
    self.mcPlayScrollerV.delegate = self;
    self.mcPlayScrollerV.pagingEnabled = YES;
    [self.view addSubview:self.mcPlayScrollerV];
    
    self.backGroundImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-144)];
    [self.mcPlayScrollerV addSubview:self.backGroundImageV];
    
    UIBlurEffect *glass = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIView * scr1 = [[UIVisualEffectView alloc] initWithEffect:glass];
    scr1.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-144);
    [self.backGroundImageV addSubview:scr1];
    
    self.musicImageV = [[UIImageView alloc]initWithFrame:CGRectMake(45, 35, kScreenWidth-90, kScreenWidth-90)];
    self.musicImageV.layer.cornerRadius = (kScreenWidth-90)/2;
    [self.musicImageV.layer setMasksToBounds:YES];
    [scr1 addSubview:self.musicImageV];
    
    self.musicNameL = [[UILabel alloc]initWithFrame:CGRectMake( 0, kScreenWidth-45, kScreenWidth, 40)];
    self.musicNameL.textAlignment = NSTextAlignmentCenter;
    self.musicNameL.textColor = [UIColor whiteColor];
    [scr1 addSubview:self.musicNameL];
    
    UIButton *likeBtn = [[UIButton alloc]init];
    likeBtn.tintColor = [UIColor whiteColor];
    [likeBtn setImage:[UIImage imageNamed:@"novel"] forState:(UIControlStateNormal)];
    likeBtn.frame = CGRectMake(50, kScreenWidth+17, 40, 30);
    [scr1 addSubview:likeBtn];
    
    self.likeL = [[UILabel alloc]initWithFrame:CGRectMake(90, kScreenWidth+17, 100, 30)];
    self.likeL.text = @"1597";
    self.likeL.textColor = [UIColor whiteColor];
    [scr1 addSubview:self.likeL];
    
    UIButton *talkBtn = [[UIButton alloc]init];
    talkBtn.tintColor = [UIColor whiteColor];
    [talkBtn setImage:[UIImage imageNamed:@"chat"] forState:(UIControlStateNormal)];
    talkBtn.frame = CGRectMake(190, kScreenWidth+17, 40, 30);
    [scr1 addSubview:talkBtn];
    
    self.talkL = [[UILabel alloc]initWithFrame:CGRectMake(230, kScreenWidth+17, 100, 30)];
    self.talkL.text = @"145456456";
    self.talkL.textColor = [UIColor whiteColor];
    [scr1 addSubview:self.talkL];
    
    self.currentTimeL = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenWidth+57, 80, 30)];
    self.currentTimeL.textAlignment = NSTextAlignmentCenter;
    self.currentTimeL.textColor = [UIColor whiteColor];
    [scr1 addSubview:self.currentTimeL];
    
    self.progressSlider = [[UISlider alloc]initWithFrame:CGRectMake(90, kScreenWidth+57, kScreenWidth-180, 30)];
    [self.progressSlider addTarget:self action:@selector(controllerProgressAction:) forControlEvents:(UIControlEventValueChanged)];
    [scr1 addSubview:self.progressSlider];
    
    self.allTimeL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90, kScreenWidth+57, 80, 30)];
    self.allTimeL.textAlignment = NSTextAlignmentCenter;
    self.allTimeL.textColor = [UIColor whiteColor];
    [scr1 addSubview:self.allTimeL];
    

    self.scr2 = [[UIWebView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-124)];
    [self.mcPlayScrollerV addSubview:self.scr2];
    
    self.scr3 =[[UITableView alloc]initWithFrame:CGRectMake(2*kScreenWidth, 0, kScreenWidth, kScreenHeight-124) style:(UITableViewStylePlain)];
    self.scr3.dataSource = self;
    self.scr3.delegate = self;
    self.scr3.rowHeight = 60;
    [self.scr3 registerClass:[MCPlayScr3TableViewCell class] forCellReuseIdentifier:@"scrCell"];
    [self.mcPlayScrollerV addSubview:self.scr3];
    
    
    DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 17;
    configuration.largeFontSize = 19;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;

    self.danmuV = [[DanmakuView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 100) configuration:configuration];
    self.danmuV.delegate = self;
    [scr1 addSubview:self.danmuV];
    
    NSString *danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray *danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    NSLog(@"%@",danmakus);
    
    [self.danmuV prepareDanmakus:danmakus];
//    DanmakuSource *source = [DanmakuSource createWithP:<#(NSString *)#> M:<#(NSString *)#>]
//  [self.danmuV prepareDanmakuSources:<#(NSArray<DanmakuSource *> *)#>]
    
    self.dianjiBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [self.dianjiBtn setTitle:@"关闭弹幕" forState:UIControlStateNormal];
    [self.dianjiBtn addTarget:self action:@selector(closeDanmu:) forControlEvents:(UIControlEventTouchUpInside)];
    self.dianjiBtn.frame = CGRectMake(20, kScreenWidth+90, 80, 40);
    [scr1 addSubview:self.dianjiBtn];
}

-(void)closeDanmu:(UIButton *)btn
{
    if ([btn.titleLabel.text isEqualToString:@"关闭弹幕"]) {
        self.danmuV.hidden = YES;
        [self.dianjiBtn setTitle:@"打开弹幕" forState:(UIControlStateNormal)];
    }else{
        self.danmuV.hidden = NO;
        [self.dianjiBtn setTitle:@"关闭弹幕" forState:(UIControlStateNormal)];
    }
    
}


-(void)creatDownView
{
    self.page = [[UIPageControl alloc]initWithFrame:CGRectMake(135, kScreenHeight-74, 100, 10)];
    self.page.numberOfPages = 3;
    self.page.pageIndicatorTintColor = [UIColor blackColor];
    self.page.currentPageIndicatorTintColor = [UIColor redColor];
    [self.page addTarget:self action:@selector(pageAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.page];
    
    self.shangBtn = [[UIButton  alloc]initWithFrame:CGRectMake(60, kScreenHeight-50, 40, 40)];
    [self.shangBtn addTarget:self action:@selector(shangBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shangBtn setImage:[UIImage imageNamed:@"music_icon_last_highlighted"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.shangBtn];
    
    self.zhongBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-210, kScreenHeight-50, 40, 40)];
    [self.zhongBtn addTarget:self action:@selector(zhongBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    if ([VideoManager shareInstance].isPlay == YES) {
        [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
    }else
    {
        [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted"] forState:(UIControlStateNormal)];
    }
    
    [self.view addSubview:self.zhongBtn];
    
    self.xiaBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-100, kScreenHeight-50, 40, 40)];
    [self.xiaBtn addTarget:self action:@selector(xiaBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.xiaBtn setImage:[UIImage imageNamed:@"music_icon_next_highlighted"] forState:(UIControlStateNormal)];
    [self.view addSubview:self.xiaBtn];
}

-(void)networkBroadcastWith:(NSInteger)index
{
    MCXQXiaBanModel *model = [VideoManager shareInstance].Array[index];
    [self.backGroundImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    [self.musicImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    self.musicNameL.text = model.title;
    
    [self.scr2 loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:model.webview_url]]];
    if (model.thereIs == NO) {
        [[VideoManager shareInstance] switchItemWithUrlString:model.musicUrl];
        model.thereIs = YES;
    }else {
        
    }
    
    [VideoManager shareInstance].passXiaModel(model);
}

-(void)localWorkBroadcastWith:(NSInteger)index
{
    LocalModel *localModel = [LocalModel localModelWithSQLArr:self.localArr[index]];
    [self.backGroundImageV sd_setImageWithURL:[NSURL URLWithString:localModel.musicImageUrl]];
    [self.musicImageV sd_setImageWithURL:[NSURL URLWithString:localModel.musicImageUrl]];
    self.musicNameL.text = localModel.musicTitle;
        
    if (localModel.isthere == NO) {
        [[VideoManager shareInstance] switchItemWithUrlString:localModel.musicUrl];
        localModel.isthere = YES;
    }else {
        
    }
//    if (localModel.isthere == NO) {
//        [[VideoManager shareInstance] localItemWithPath:localModel.musicPath];
//        localModel.isthere = YES;
//    }
   [VideoManager shareInstance].localModelPass(localModel);
    
}

-(void)timerAction
{
    // 如果为0 证明数据还没有请求下来  导致下列运算中 除数=0 无法进行
    if ([VideoManager shareInstance].player.currentTime.timescale == 0|| [VideoManager shareInstance].player.currentItem.duration.timescale == 0)
    {
        return;
    }
    
    long long int currentTime = [VideoManager shareInstance].player.currentTime.value / [VideoManager shareInstance].player.currentTime.timescale;
    
    // 获取当前音频/视频的总时间
    long long int alltime = [VideoManager shareInstance].player.currentItem.duration.value / [VideoManager shareInstance].player.currentItem.duration.timescale;
    
    self.allTimeL.text = [NSString stringWithFormat:@"%02lld:%02lld",alltime / 60, alltime % 60];
    self.currentTimeL.text = [NSString stringWithFormat:@"%02lld:%02lld",currentTime /60 , currentTime%60];
    
    // 滑条最大值等于 总时长
    self.progressSlider.maximumValue = alltime;
    // 滑条当前值等于 当前时间
    self.progressSlider.value = currentTime;
    
    // 如果播放的进度已经快要完成了 进行自动播放下一首歌曲
    if (self.progressSlider.value >= alltime - 1)
    {
        if (self.localArr.count == 0) {
            NSInteger index = [VideoManager shareInstance].index;
            MCXQXiaBanModel *model = [VideoManager shareInstance].Array[index];
            model.thereIs = NO;
            
            // 先改变下标
            [[VideoManager shareInstance] autoPlay];
            // 在修改界面 切换歌曲
            [self networkBroadcastWith:[VideoManager shareInstance].index];
        }
        else
        {
            // 先改变下标
            [[VideoManager shareInstance] autoPlay];
            [self localWorkBroadcastWith:[VideoManager shareInstance].index];
        }
    }
    
    if ([VideoManager shareInstance].isPlay == NO) {
        return;
    }
}

-(void)mcPlayBackBtnAction
{
    if (self.localArr.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if ([VideoManager shareInstance].isPlay == YES) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBoFangStart" object:nil];
    }else{
        NSLog(@"没有发送通知");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBoFangStop" object:nil];
    }
}


-(void)cutPlayTpe
{
    if ([VideoManager shareInstance].playState == ordinaryPlay) {
        [VideoManager shareInstance].playState = randomPlay;
        [self.playTypeBtn setTitle:@"随机" forState:(UIControlStateNormal)];
        return;
    }
    else if ([VideoManager shareInstance].playState == randomPlay){
        [VideoManager shareInstance].playState = singlePlay;
        [self.playTypeBtn setTitle:@"单曲" forState:(UIControlStateNormal)];
        return;
    }
    else if ([VideoManager shareInstance].playState == singlePlay){
        [VideoManager shareInstance].playState = ordinaryPlay;
        [self.playTypeBtn setTitle:@"普通" forState:(UIControlStateNormal)];
        return;
    }
}

-(void)shangBtnAction
{
    [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
    if (self.localArr.count == 0) {
        NSInteger index = [VideoManager shareInstance].index;
        MCXQXiaBanModel *model = [VideoManager shareInstance].Array[index];
        model.thereIs = NO;
        [[VideoManager shareInstance] topVideo];
        [self networkBroadcastWith:[VideoManager shareInstance].index];
    }
    else
    {
        [[VideoManager shareInstance] topVideo];
        [self localWorkBroadcastWith:[VideoManager shareInstance].index];
    }
    
}

-(void)zhongBtnAction
{
    [[VideoManager shareInstance] endOrStartPlay];
    if ([VideoManager shareInstance].isPlay == YES)
    {
        [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
        [self.musicImageV.layer resumeAnimate];

    }
    else
    {
        //[self.musicImageV.layer addAnimation:self.cabmation forKey:nil];
        [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted"] forState:(UIControlStateNormal)];
        [self.musicImageV.layer pauseAnimate];
    }

}

-(void)xiaBtnAction
{
    [self.zhongBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
    if (self.localArr.count == 0) {
        NSInteger index = [VideoManager shareInstance].index;
        MCXQXiaBanModel *model = [VideoManager shareInstance].Array[index];
        model.thereIs = NO;
        [[VideoManager shareInstance] nextVideo];
        [self networkBroadcastWith:[VideoManager shareInstance].index];
    }
    else
    {
        [[VideoManager shareInstance] nextVideo];
        [self localWorkBroadcastWith:[VideoManager shareInstance].index];
    }
}

-(void)controllerProgressAction:(UISlider *)sl
{
    [[VideoManager shareInstance] ctrolVolumeWithProgressFloat:sl.value];
}


-(void)pageAction
{
    self.mcPlayScrollerV.contentOffset = CGPointMake(self.page.currentPage * kScreenWidth, 0);
}


-(void)downMusic:(UIButton *)btn
{
    MCPlayScr3TableViewCell *cell = (MCPlayScr3TableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.scr3 indexPathForCell:cell];
    MCXQXiaBanModel *model = [VideoManager shareInstance].Array[indexPath.row];
    DownLoadManager *dManager = [DownLoadManager shareInstance];
    DownLoad *task = [dManager creatDownload:model.musicUrl];

    [task monitorDownloading:^(long long bytesWritten, NSInteger progress) {
      //  NSLog(@"%lld,%ld",bytesWritten,progress);
    } DidDownload:^(NSString *savePath, NSString *url) {
        NSLog(@"%@",savePath);
        [btn setTitle:@"完成" forState:(UIControlStateNormal)];
        model.downType = diDown;

        // 保存数据
        DownMusicTable *table = [[DownMusicTable alloc]init];
        [table creatTable];
        NSArray *arr = [table selectAll];
        BOOL isSave = NO;
        for (NSMutableArray *marr in arr) {
            if ([marr.lastObject isEqualToString:savePath]) {
                isSave = YES;
              //  NSLog(@"已经保存过");
            }
        }
        if (!isSave) {
            [table insetIntoTable:@[model.title,model.musicUrl,model.coverimg,savePath]];
        }
    }];

    if ([btn.titleLabel.text isEqualToString:@"下载"])
    {
        model.downType = susDowning;
        [btn setTitle:@"暂停" forState:(UIControlStateNormal)];

        [task startDown];
    }
    else if ([btn.titleLabel.text isEqualToString:@"暂停"])
    {
        model.downType = startDowning;
        [btn setTitle:@"开始" forState:(UIControlStateNormal)];

        [task suspendDown];

    }
    else if ([btn.titleLabel.text isEqualToString:@"开始"])
    {
        model.downType = susDowning;
        [btn setTitle:@"暂停" forState:(UIControlStateNormal)];
        
        [task startDown];

    }
    else if ([btn.titleLabel.text isEqualToString:@"完成"])
    {
       // NSLog(@"已经下载完成");
    }

}


#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.musicUrlArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MCPlayScr3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scrCell" forIndexPath:indexPath];
    UIButton *btn = cell.downLoadBtn;
    [btn addTarget:self action:@selector(downMusic:) forControlEvents:(UIControlEventTouchUpInside)];
    MCXQXiaBanModel *model = [VideoManager shareInstance].Array[indexPath.row];
    cell.model = model;

    if (model.downType == diDown){
        [btn setTitle:@"完成" forState:(UIControlStateNormal)];
    }
    if (model.downType == susDowning)
    {
        [btn setTitle:@"暂停" forState:(UIControlStateNormal)];
    }
    if (model.downType == startDowning)
    {
        [btn setTitle:@"开始" forState:(UIControlStateNormal)];
    }
    
    if(model.downType == noDown){
        [btn setTitle:@"下载" forState:(UIControlStateNormal)];
    }

    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = scrollView.contentOffset.x / kScreenWidth;
}

#pragma mark ===danmu ====
// 视频播放进度，单位秒
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return self.progressSlider.value;
}

// 视频播放缓冲状态，如果设为YES，不会绘制新弹幕，已绘制弹幕会继续动画直至消失
- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView;
{
    return NO;
}

- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView
{
    [self.danmuV start];
}





@end
