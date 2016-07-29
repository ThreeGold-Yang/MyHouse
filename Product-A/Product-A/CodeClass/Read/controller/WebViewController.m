//
//  WebViewController.m
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "WebViewController.h"
#import "TalkViewController.h"
@interface WebViewController ()
@property(nonatomic,strong) UIView *TopV;
@property(nonatomic,strong) UIButton *webBackBtn;
@property(nonatomic,strong) UILabel *webTitleL;
@property(nonatomic,strong) UIButton *liuyanBtn;
@property(nonatomic,strong) UIButton *xihuanBtn;
@property(nonatomic,strong) UIButton *fenxiangBtn;
@end

@implementation WebViewController
-(UIView *)TopV
{
    if (!_TopV) {
        _TopV = [[UIView alloc]init];
        _TopV.frame = CGRectMake(0, 20, kScreenWidth, 40);
    }
    return _TopV;
}
-(UIButton *)webBackBtn
{
    if (!_webBackBtn) {
        _webBackBtn = [[UIButton alloc]init];
        _webBackBtn.frame = CGRectMake(0, 0, 50, 40);
        [_webBackBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
        [_webBackBtn addTarget:self action:@selector(webBackBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _webBackBtn;
}

-(UIButton *)liuyanBtn
{
    if (!_liuyanBtn) {
        _liuyanBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        CGFloat jianju = (kScreenWidth - 240) / 3;
        _liuyanBtn.frame = CGRectMake(40 + 50 + jianju, 0, 50, 40);
        [_liuyanBtn setImage:[UIImage imageNamed:@"chat"] forState:(UIControlStateNormal)];
        [_liuyanBtn addTarget:self action:@selector(webjumpTalkVC) forControlEvents:(UIControlEventTouchUpInside)];
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
        [_fenxiangBtn setImage:[UIImage imageNamed:@"navigationbar_more"] forState:(UIControlStateNormal)];
    }
    return _fenxiangBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TopV];
    [self.TopV addSubview:self.webBackBtn];
    [self.TopV addSubview:self.liuyanBtn];
    [self.TopV addSubview:self.xihuanBtn];
    [self.TopV addSubview:self.fenxiangBtn];
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH+1, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
    
    
    
    
    [RequestManager requestDataWithUrlString:KNoteURL parDic:self.dic finish:^(NSData *data) {
        
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

-(void)webBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)webjumpTalkVC
{
    TalkViewController *talkVC = [[TalkViewController alloc]init];
    talkVC.ss = self.ss;
    [self.navigationController pushViewController:talkVC animated:YES];
}
@end
