//
//  RootViewController.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//


#define KCAGradientLayerH   kScreenHeight / 3.0
#import "RootViewController.h"
#import "RightViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
#import "LocalViewController.h"
#import "MCXQXiaBanModel.h"
#import "MCPlayViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *controllers;
@property(nonatomic,strong) NSArray *titles; // 存放每个控制器的名字
@property(nonatomic,assign) BOOL    isChoose;
@property(nonatomic,strong) UINavigationController *navcRoot;
@property(nonatomic,strong) RightViewController *rightVC;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) UILabel *userL;
@property(nonatomic,strong) UIImageView *headV;
@property(nonatomic,strong) UIButton *bofangBtn;
@end

@implementation RootViewController

// 状态栏白色高亮字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



#pragma mark === ViewWill ====
-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initGradientLayer];
    [self initDownView];// 顺序
    [self initTopView];
    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBoFangStart:) name:@"changeBoFangStart" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBoFangStop:) name:@"changeBoFangStop" object:nil];
    
}

-(void)changeBoFangStart:(NSNotification *)note
{
    [self.bofangBtn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
}

-(void)changeBoFangStop:(NSNotification *)note
{
    [self.bofangBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted"] forState:(UIControlStateNormal)];
}


// 设置彩虹色
-(void)initGradientLayer
{
    // 渐变色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];
    gradientLayer.frame = CGRectMake(0, 20, kScreenWidth, KCAGradientLayerH);
    gradientLayer.colors = @[(id)PKCOLOR(180, 180, 180).CGColor,(id)PKCOLOR(100, 60, 155).CGColor,(id)PKCOLOR(120, 40, 40).CGColor];
    [self.view.layer addSublayer:gradientLayer];
}

// tableView创建
-(void)initTableView
{
    _controllers = @[@"MCTaiViewController",@"ReadViewController",@"CommunityViewController",@"LiangPingViewController",@"SettingViewController"];
    _titles = @[@"电台",@"阅读",@"社区",@"良品",@"设置"];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20+KCAGradientLayerH, kScreenWidth, kScreenHeight - 20 - KCAGradientLayerH - 64)]; // 64是最下方的高度
    
    tableView.rowHeight = tableView.height / _titles.count; // 均分 获得cell高度
    tableView.backgroundColor = PKCOLOR(120, 40, 40);
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rootcell"];
    [self.view addSubview:tableView];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 关闭分割线
    [tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
    
    _rightVC = [[NSClassFromString(_controllers[0]) alloc]init];
    _rightVC.titleLabel.text = _titles[0];
    _navcRoot = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    _navcRoot.navigationBar.hidden = YES;
    [self.view addSubview:_navcRoot.view];
    
}
// 创建最下面的View
-(void)initDownView
{
    UIView *downV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-64, kScreenWidth-KMoveDistance, 64)];
    downV.backgroundColor = PKCOLOR(120, 40, 40);
    [self.view addSubview:downV];
    
    UIImageView *musicImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    musicImageV.image = [UIImage imageNamed:@"mm15.jpg"];
    [downV addSubview:musicImageV];
    
    UILabel *musicNameL = [[UILabel alloc]initWithFrame:CGRectMake(70, 30, 100, 30)];
    musicNameL.font = [UIFont systemFontOfSize:15];
    musicNameL.text = @"未知";
    musicNameL.textColor = [UIColor whiteColor];
    [downV addSubview:musicNameL];
    
    UILabel *musicTitleL = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 150, 30)];
    musicTitleL.font = [UIFont systemFontOfSize:15];
    musicTitleL.textColor = [UIColor whiteColor];
    musicTitleL.text = @"没有播放";
    [downV addSubview:musicTitleL];
    
    self.bofangBtn = [[UIButton alloc]init];
    self.bofangBtn.frame = CGRectMake(240, 12, 40, 40);
    [self.bofangBtn addTarget:self action:@selector(rootPlayerOrPauseBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.bofangBtn setImage:[UIImage imageNamed:@"music_icon_play_highlighted"] forState:(UIControlStateNormal)];
    [downV addSubview:self.bofangBtn];
    
    
    VideoManager *manager = [VideoManager shareInstance];
    manager.passXiaModel = ^(MCXQXiaBanModel *model){
        [musicImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        musicTitleL.text = model.title;
        musicNameL.text = model.uname;
    };
    manager.localModelPass = ^(LocalModel *localModel){
        [musicImageV sd_setImageWithURL:[NSURL URLWithString:localModel.musicImageUrl] placeholderImage:placeHoldImageURL completed:nil];
        musicTitleL.text = localModel.musicTitle;
    };
    
}
-(void)rootPlayerOrPauseBtn:(UIButton *)btn
{
    [[VideoManager shareInstance] endOrStartPlay];
    if ([VideoManager shareInstance].isPlay == YES)
    {
        [btn setImage:[UIImage imageNamed:@"music_icon_stop_highlighted"] forState:(UIControlStateNormal)];
        
    }
    else
    {
        [btn setImage:[UIImage imageNamed:@"music_icon_play_highlighted"] forState:(UIControlStateNormal)];
        
    }

}
// 创建最上面的View
-(void)initTopView
{
    UIView *bigV = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth-KMoveDistance, KCAGradientLayerH)];
    [self.view addSubview:bigV];
    
    self.headV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, KCAGradientLayerH / 2 - 40, KCAGradientLayerH / 2 - 40)];
    self.headV.layer.cornerRadius = (KCAGradientLayerH / 2 - 40) / 2 ;
    [self.headV.layer setMasksToBounds:YES];
    self.headV.backgroundColor = [UIColor redColor];
    if ([[UserInfoManager getUserName] isEqualToString:@" "]) {
        
    }else{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[UserInfoManager getUserIcon]]];
        self.headV.image = [UIImage imageWithData:data];
    }
    [bigV addSubview:self.headV];
    
    self.userL = [[UILabel alloc]initWithFrame:CGRectMake(15 + KCAGradientLayerH / 2 - 40 + 15, 20, 100, 30)];
    if ([[UserInfoManager getUserName] isEqualToString:@" "]) {
        self.userL.text = @"未登录";
    }else{
        self.userL.text = [UserInfoManager getUserName];
    }
    [bigV addSubview:self.userL];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginBtn.frame = CGRectMake(15 + KCAGradientLayerH / 2 - 40 + 15 , 20 + (KCAGradientLayerH / 2 - 40) / 2, 50, 30);
    if ([[UserInfoManager getUserName] isEqualToString:@" "]) {
        [self.loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    }else{
        [self.loginBtn setTitle:@"注销" forState:(UIControlStateNormal)];
    }
    
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.loginBtn addTarget:self action:@selector(jumpLoginVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:self.loginBtn];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(15 + KCAGradientLayerH / 2 - 40 + 15 + 5 + 50, 20 + (KCAGradientLayerH / 2 - 40) / 2, 1, 30)];
    lable.backgroundColor = [UIColor whiteColor];
    [bigV addSubview:lable];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registBtn.frame = CGRectMake(15 + KCAGradientLayerH / 2 - 40 + 15 + 5 + 50 + 5, 20 + (KCAGradientLayerH / 2 - 40) / 2, 50, 30);
    [registBtn setTitle:@"注册" forState:(UIControlStateNormal)];
    [registBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [registBtn addTarget:self action:@selector(jumpRegistVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:registBtn];
    
    float w = 75.0;
    UIButton *cacheBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    cacheBtn.frame = CGRectMake(20, 150, 40, 40);
    [cacheBtn setImage:[UIImage imageNamed:@"down"] forState:(UIControlStateNormal)];
    [cacheBtn addTarget:self action:@selector(jumpCacheVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:cacheBtn];
    
    UIButton *likeBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    likeBtn.frame = CGRectMake(20 + w,150, 40, 40);
    [likeBtn setImage:[UIImage imageNamed:@"novel"] forState:(UIControlStateNormal)];
    [likeBtn addTarget:self action:@selector(jumpLikeVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:likeBtn];
    
    UIButton *leaveMessageBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    leaveMessageBtn.frame = CGRectMake(20 + 2*w, 150, 40, 40);
    [leaveMessageBtn setImage:[UIImage imageNamed:@"chat"] forState:(UIControlStateNormal)];
    [leaveMessageBtn addTarget:self action:@selector(jumpLeaveMessageVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:leaveMessageBtn];
    
    UIButton *editBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    editBtn.frame = CGRectMake(20 + 3*w, 150, 40, 40);
    [editBtn setImage:[UIImage imageNamed:@"edit"] forState:(UIControlStateNormal)];
    [editBtn addTarget:self action:@selector(jumpEditVC) forControlEvents:(UIControlEventTouchUpInside)];
    [bigV addSubview:editBtn];
}

-(void)jumpLoginVC
{
     LoginViewController *loginVC = [[LoginViewController alloc]init];
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登录"]) {
        loginVC.loginSuccess = ^{
            self.userL.text = [UserInfoManager getUserName];
            [self.loginBtn setTitle:@"注销" forState:(UIControlStateNormal)];
            //NSLog(@"%@",[UserInfoManager getUserIcon]);
            [self.headV sd_setImageWithURL:[NSURL URLWithString:[UserInfoManager getUserIcon]] placeholderImage:placeHoldImageURL completed:nil];
        };
    }else if ([self.loginBtn.titleLabel.text isEqualToString:@"注销"]){
        [self.loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
        self.userL.text = @"未登录";
        [UserInfoManager cancelUserAuth];
        [UserInfoManager cancelUserID];
        [UserInfoManager cancelUserName];
        [UserInfoManager cancelUserIcon];
    }
   [self presentViewController:loginVC animated:YES completion:nil];
    
}
-(void)jumpRegistVC
{
    RegistViewController *registVC = [[RegistViewController alloc]init];
    [self presentViewController:registVC animated:YES completion:nil];
}
-(void)jumpCacheVC
{
    DownMusicTable *table = [[DownMusicTable alloc]init];
    LocalViewController *localVC = [[LocalViewController alloc]init];
    NSMutableArray *arr = [table selectAll];
    localVC.array = arr;
    
    [self presentViewController:localVC animated:YES completion:nil];
}
-(void)jumpLikeVC
{
    
}
-(void)jumpLeaveMessageVC
{
    
}
-(void)jumpEditVC
{
    
}

#pragma mark ---tableView的协议方法---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rootcell" forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.textColor = PKCOLOR(70, 100, 150);
    // 选取的背景图，不用添加
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor grayColor];
    
    cell.backgroundColor = PKCOLOR(120, 40, 40);
    if (indexPath.row == 0 && cell.isSelected == YES) {
        cell.textLabel.textColor = PKCOLOR(240, 240, 240);
    }
    return cell;
}
// 选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = PKCOLOR(190, 10, 90);
    if ([_rightVC isMemberOfClass:[NSClassFromString(_controllers[indexPath.row])class]]) {
        NSLog(@"重复点击");
        [_rightVC ChangeFrameWithType:MoveTypeLeft];
        return;
    }
    
    [_navcRoot.view removeFromSuperview];
    
    _rightVC = [[NSClassFromString(_controllers[indexPath.row]) alloc]init];
    _rightVC.titleLabel.text = _titles[indexPath.row];
    _navcRoot = [[UINavigationController alloc]initWithRootViewController:_rightVC];
    _navcRoot.navigationBar.hidden = YES;
    [self.view addSubview:_navcRoot.view];
    
    _navcRoot.view.frame = CGRectMake(kScreenWidth - KMoveDistance, 0, kScreenWidth, kScreenHeight);
//    CGRect newFrame = _navcRoot.view.frame;
//    newFrame.origin.x = kScreenWidth - KMoveDistance;
//    _navcRoot.view.frame = newFrame;
    
    [_rightVC ChangeFrameWithType:MoveTypeLeft];
    
    
}
//结束选中
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = PKCOLOR(70, 100, 150);
    cell.backgroundColor = PKCOLOR(120, 40, 40);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
