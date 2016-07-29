//
//  LiangPinXiangQinViewController.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPinXiangQinViewController.h"
#import "LiangPinTalkModel.h"
#import "LiangPinAuthorModel.h"
@interface LiangPinXiangQinViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIView *TopV;
@property(nonatomic,strong) UIButton *liangPinXiangQinBackBtn;
@property(nonatomic,strong) NSMutableDictionary *parDic;
@property(nonatomic,strong) NSMutableArray *authorModelArray;
@property(nonatomic,strong) NSMutableArray *talkModelArray;
@property(nonatomic,strong) UITableView *backgroundTableV;
@property(nonatomic,strong) NSString *webStr;
@end

@implementation LiangPinXiangQinViewController

-(NSMutableArray *)authorModelArray
{
    if (!_authorModelArray) {
        _authorModelArray = [NSMutableArray array];
    }
    return _authorModelArray;
}

-(NSMutableArray *)talkModelArray
{
    if (!_talkModelArray) {
        _talkModelArray = [NSMutableArray array];
    }
    return _talkModelArray;
}


-(UITableView *)backgroundTableV
{
    if (!_backgroundTableV) {
        _backgroundTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60) style:(UITableViewStyleGrouped)];
        _backgroundTableV.backgroundColor = [UIColor whiteColor];
        _backgroundTableV.dataSource = self;
        _backgroundTableV.delegate = self;
    }
    return _backgroundTableV;
}

-(UIView *)TopV
{
    if (!_TopV) {
        _TopV = [[UIView alloc]init];
        _TopV.backgroundColor = [UIColor whiteColor];
        _TopV.frame = CGRectMake(0, 20, kScreenWidth, 40);
    }
    return _TopV;
}
-(UIButton *)liangPinXiangQinBackBtn
{
    if (!_liangPinXiangQinBackBtn) {
        _liangPinXiangQinBackBtn = [[UIButton alloc]init];
        _liangPinXiangQinBackBtn.frame = CGRectMake(0, 0, 40, 40);
        [_liangPinXiangQinBackBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
        [_liangPinXiangQinBackBtn addTarget:self action:@selector(_liangPinXiangQinBackBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _liangPinXiangQinBackBtn;
}

-(void)_liangPinXiangQinBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TopV];
    [self.TopV addSubview:self.liangPinXiangQinBackBtn];
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];

    [self.view addSubview:self.backgroundTableV];
    
    
    self.parDic = [@{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"contentid":self.ss,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31",@"version":@"3.0.6"}mutableCopy];
    
    [self authorModelRequestData];
    [self talkModelRequestData];
    
    [self.backgroundTableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"liangpinxiangqin"];
    
}

-(void)authorModelRequestData
{
    [RequestManager requestDataWithUrlString:KLiangPinXiangQingURL parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *postsinfoDic = [dic[@"data"] valueForKey:@"postsinfo"];
        NSString *htmlString = postsinfoDic[@"html"];
        self.webStr = [NSString importStyleWithHtmlString:htmlString];
        self.authorModelArray = [LiangPinAuthorModel modelConfigureWithJsonDic:dic];
       // NSLog(@"auth====%ld",self.authorModelArray.count);
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

-(void)talkModelRequestData
{
    [RequestManager requestDataWithUrlString:KLiangPinXiangQingURL parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.talkModelArray = [LiangPinTalkModel modelConfigureWithJsonDic:dic];
       // NSLog(@"talk====%ld",self.talkModelArray.count);
        [self.backgroundTableV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.talkModelArray.count;
    //return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
   // LiangPinTalkModel *model = self.talkModelArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liangpinxiangqin" forIndexPath:indexPath];
    cell.textLabel.text = @"1230";
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
    headV.backgroundColor = [UIColor redColor];

    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
    web.backgroundColor = [UIColor whiteColor];
    [headV addSubview:web];
    [web loadHTMLString:self.webStr baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
   // NSLog(@"%@",self.webStr);
    return headV;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenHeight-60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
@end
