//
//  LiangPingViewController.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LiangPingViewController.h"
#import "LiangPinShouYeModel.h"
#import "LiangPinShouYeTableViewCell.h"
#import "LiangPinXiangQinViewController.h"
@interface LiangPingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *liangPinShouYeTableV;
@property(nonatomic,strong) NSMutableArray *liangPinShouYeArray;
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,strong) NSMutableDictionary *liangPinShouYeDic;

@end

@implementation LiangPingViewController
-(NSMutableArray *)liangPinShouYeArray
{
    if (!_liangPinShouYeArray) {
        _liangPinShouYeArray = [NSMutableArray array];
    }
    return _liangPinShouYeArray;
}
-(NSMutableDictionary *)liangPinShouYeDic
{
    if (!_liangPinShouYeDic) {
        _liangPinShouYeDic = [[NSMutableDictionary alloc]init];
    }
    return _liangPinShouYeDic;
}
-(UITableView *)liangPinShouYeTableV
{
    if (!_liangPinShouYeTableV) {
        _liangPinShouYeTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, kScreenHeight-61) style:(UITableViewStylePlain)];
        _liangPinShouYeTableV.dataSource = self;
        _liangPinShouYeTableV.delegate = self;
        _liangPinShouYeTableV.rowHeight = 230;
    }
    return _liangPinShouYeTableV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.liangPinShouYeTableV];
    
    [self.liangPinShouYeTableV registerClass:[LiangPinShouYeTableViewCell class] forCellReuseIdentifier:@"liangpinshouye"];
    
    self.index = 0;
    self.liangPinShouYeDic = [@{@"start":[NSString stringWithFormat:@"%ld",self.index],@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"limit":@"10",@"auth":@"",@"version":@"3.0.2"} mutableCopy];
    [self liangPinShouYeRequestData];
    
    self.liangPinShouYeTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        self.liangPinShouYeDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self.liangPinShouYeArray removeAllObjects];
        [self liangPinShouYeRequestData];
    }];
    
    self.liangPinShouYeTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.index += 10;
        self.liangPinShouYeDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self liangPinShouYeRequestData];
    }];
    
    
}

-(void)liangPinShouYeRequestData
{
    [RequestManager requestDataWithUrlString:KLiangPinShouYeURL parDic:self.liangPinShouYeDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [NSMutableArray array];
        arr = [LiangPinShouYeModel modelConfigureWithJsonDic:dic];
        for (LiangPinShouYeModel *model in arr) {
            [self.liangPinShouYeArray addObject:model];
        }
        [self.liangPinShouYeTableV.mj_header endRefreshing];
        [self.liangPinShouYeTableV.mj_footer endRefreshing];
        [self.liangPinShouYeTableV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.liangPinShouYeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    LiangPinShouYeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liangpinshouye" forIndexPath:indexPath];
    LiangPinShouYeModel *model = self.liangPinShouYeArray[indexPath.row];
    cell.model = model;
    [cell.buyBtn addTarget:self action:@selector(buyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;
}

-(void)buyAction:(UIButton *)btn
{
    LiangPinShouYeTableViewCell *cell = (LiangPinShouYeTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.liangPinShouYeTableV indexPathForCell:cell];
    LiangPinShouYeModel *model = self.liangPinShouYeArray[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.buyurl]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiangPinShouYeModel *model = self.liangPinShouYeArray[indexPath.row];
    LiangPinXiangQinViewController *liangPinXiangQinVC = [[LiangPinXiangQinViewController alloc]init];
    liangPinXiangQinVC.ss = model.contentid;
    [self.navigationController pushViewController:liangPinXiangQinVC animated:YES];
}

@end
