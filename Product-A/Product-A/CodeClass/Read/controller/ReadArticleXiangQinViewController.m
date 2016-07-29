//
//  ReadArticleXiangQinViewController.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ReadArticleXiangQinViewController.h"
#import "TalkViewController.h"
@interface ReadArticleXiangQinViewController ()
@property(nonatomic,strong) UIView *TopV;
@property(nonatomic,strong) UIButton *readArticleXiangQinBackBtn;
@property(nonatomic,strong) NSMutableDictionary *parDic;
@property(nonatomic,strong) UIButton *liuyanBtn;
@property(nonatomic,strong) UIButton *xihuanBtn;
@property(nonatomic,strong) UIButton *fenxiangBtn;
@end

@implementation ReadArticleXiangQinViewController

-(UIView *)TopV
{
    if (!_TopV) {
        _TopV = [[UIView alloc]init];
        _TopV.frame = CGRectMake(0, 20, kScreenWidth, 40);
    }
    return _TopV;
}
-(UIButton *)readArticleXiangQinBackBtn
{
    if (!_readArticleXiangQinBackBtn) {
        _readArticleXiangQinBackBtn = [[UIButton alloc]init];
        _readArticleXiangQinBackBtn.frame = CGRectMake(0, 0, 40, 40);
        [_readArticleXiangQinBackBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
        [_readArticleXiangQinBackBtn addTarget:self action:@selector(readArticleXiangQinBackBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _readArticleXiangQinBackBtn;
}

-(UIButton *)liuyanBtn
{
    if (!_liuyanBtn) {
        _liuyanBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        CGFloat jianju = (kScreenWidth - 240) / 3;
        _liuyanBtn.frame = CGRectMake(40 + 50 + jianju, 0, 50, 40);
        [_liuyanBtn setImage:[UIImage imageNamed:@"chat"] forState:(UIControlStateNormal)];
        [_liuyanBtn addTarget:self action:@selector(jumpTalkVC) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _liuyanBtn;
}

-(UIButton *)xihuanBtn
{
    if (!_xihuanBtn) {
        _xihuanBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        CGFloat jianju = (kScreenWidth - 240) / 3;
        _xihuanBtn.frame = CGRectMake(40 + (50 +jianju)*2, 0, 50, 40);
        [_xihuanBtn setImage:[UIImage imageNamed:@"novel"] forState:(UIControlStateNormal)];
    }
    return _xihuanBtn;
}

-(UIButton *)fenxiangBtn
{
    if (!_fenxiangBtn) {
        _fenxiangBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        CGFloat jianju = (kScreenWidth - 240) / 3;
        _fenxiangBtn.frame = CGRectMake(40 + (50 +jianju)*3, 0, 50, 40);
        [_fenxiangBtn addTarget:self action:@selector(fenxiangBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fenxiangBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:(UIControlStateNormal)];
    }
    return _fenxiangBtn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parDic = [@{@"contentid":self.ss,@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"version":@"3.0.2"} mutableCopy];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TopV];
    [self.TopV addSubview:self.readArticleXiangQinBackBtn];
    [self.TopV addSubview:self.liuyanBtn];
    [self.TopV addSubview:self.xihuanBtn];
    [self.TopV addSubview:self.fenxiangBtn];
    
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH+1, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
  
    
    [RequestManager requestDataWithUrlString:KNoteURL parDic:self.parDic finish:^(NSData *data) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSString *str = dataDic[@"html"];
        NSString *HTML = [NSString importStyleWithHtmlString:str];
        UIWebView *webV = [[UIWebView alloc]initWithFrame:CGRectMake(0, 62, kScreenWidth, kScreenHeight-62)];
        [webV loadHTMLString:HTML baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
        [self.view addSubview:webV];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];

}

-(void)readArticleXiangQinBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)jumpTalkVC
{
    TalkViewController *talkVC = [[TalkViewController alloc]init];
    talkVC.ss = self.ss;
    [self.navigationController pushViewController:talkVC animated:YES];
}

-(void)fenxiangBtnAction
{
    
    NSArray *imageArray = @[self.coverimg];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"这里是分享" images:imageArray url:[NSURL URLWithString:@"http://mob.com"] title:@"分享啥呢！" type:SSDKContentTypeAuto];
       // NSArray *arr = @[@"1",@"997"];
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            if (state == SSDKResponseStateSuccess) {
               // NSLog(@"我要分享");
            }
            else{
               // NSLog(@"我不要分享");
            }
        }];
    
    }
}


@end
