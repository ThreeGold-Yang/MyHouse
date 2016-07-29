//
//  CommunityViewController.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommShouYeModel.h"
#import "CommHotOneTableViewCell.h"
#import "CommHotTwoTableViewCell.h"
#import "CommNewOneTableViewCell.h"
#import "CommNewTwoTableViewCell.h"

#import "CommXQViewController.h"

@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *commScrollerV;
@property(nonatomic,strong) UISegmentedControl *segmentV;
@property(nonatomic,strong) UITableView *commHotTableV;
@property(nonatomic,strong) UITableView *commNewTableV;


@property(nonatomic,strong) NSMutableDictionary *parDic;
@property(nonatomic,strong) NSMutableArray *commHotArr;
@property(nonatomic,strong) NSMutableArray *commNewArr;

@property(nonatomic,assign) NSInteger index;

@end

@implementation CommunityViewController

#pragma mark ==== 懒加载 ====
-(NSMutableArray *)commHotArr
{
    if (!_commHotArr) {
        _commHotArr = [NSMutableArray array];
    }
    return _commHotArr;
}

-(NSMutableArray *)commNewArr
{
    if (!_commNewArr) {
        _commNewArr = [NSMutableArray array];
    }
    return _commNewArr;
}

#pragma mark ==== ViewWill ====
-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parDic = [@{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"client":@"1",@"sort":@"addtime",@"limit":@"10",@"version":@"3.0.2",@"start":@"0",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0"} mutableCopy];
    
    [self creatScrollerView];
    [self commHotRequsetData];
    
    // HOT
    [self.commHotTableV registerClass:[CommHotOneTableViewCell class] forCellReuseIdentifier:@"hotOne"];
    [self.commHotTableV registerClass:[CommHotTwoTableViewCell class] forCellReuseIdentifier:@"hotTwo"];
    
    self.commHotTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self commHotRequsetData];
    }];
    
    self.commHotTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.index += 10;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self commHotRequsetData];
    }];
    
    // NEW
    [self.commNewTableV registerClass:[CommNewOneTableViewCell class] forCellReuseIdentifier:@"newOne"];
    [self.commNewTableV registerClass:[CommNewTwoTableViewCell class] forCellReuseIdentifier:@"newTwo"];
    
    self.commNewTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self commNewRequestData];
    }];
    
    self.commNewTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.index += 10;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self commNewRequestData];
    }];

    
    
}


#pragma mark ====方法====
-(void)creatScrollerView
{
    self.segmentV = [[UISegmentedControl alloc]initWithItems:@[@"Hot",@"New"]];
    self.segmentV.frame = CGRectMake(100, 70, kScreenWidth-200, 30);
    [self.segmentV addTarget:self action:@selector(chooseTableV:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentV.selectedSegmentIndex = 0;
    self.segmentV.tintColor = [UIColor redColor];// 边框颜色和 item颜色
    [self.view addSubview:self.segmentV];
    
    self.commScrollerV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 110, kScreenWidth, kScreenHeight-110)];
    self.commScrollerV.pagingEnabled = YES;
    self.commScrollerV.delegate = self;
    self.commScrollerV.contentSize = CGSizeMake(2*kScreenWidth, 0);
    self.commScrollerV.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.commScrollerV];
    
    self.commHotTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-110)];
    self.commHotTableV.dataSource = self;
    self.commHotTableV.delegate = self;
    [self.commScrollerV addSubview:self.commHotTableV];
    
    self.commNewTableV = [[UITableView alloc]initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-110)];
    self.commNewTableV.dataSource = self;
    self.commNewTableV.delegate = self;
    [self.commScrollerV addSubview:self.commNewTableV];
    
}

-(void)commHotRequsetData
{
    self.parDic[@"sort"] = @"hot";
    self.requestState = hotState;
    [RequestManager requestDataWithUrlString:KHuaTiShouYeUrl parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *hotA = [CommShouYeModel modelWith:dic];
        for (CommShouYeModel *model in hotA) {
            [self.commHotArr addObject:model];
        }
        [self.commHotTableV.mj_header endRefreshing];
        [self.commHotTableV.mj_footer endRefreshing];
        [self.commHotTableV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"hot===%@",error);
    }];
}

-(void)commNewRequestData
{
    self.parDic[@"sort"] = @"addtime";
    [RequestManager requestDataWithUrlString:KHuaTiShouYeUrl parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *newA = [CommShouYeModel modelWith:dic];
        for (CommShouYeModel *model in newA) {
            [self.commNewArr addObject:model];
        }
        [self.commNewTableV.mj_header endRefreshing];
        [self.commNewTableV.mj_footer endRefreshing];
        [self.commNewTableV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"hot===%@",error);
    }];

}

-(void)chooseTableV:(UISegmentedControl *)segment
{
    if (segment.selectedSegmentIndex == 0) {
        [self commHotRequsetData];
        self.commScrollerV.contentOffset = CGPointMake(0, 0);
    }else{
        [self commNewRequestData];
        self.commScrollerV.contentOffset = CGPointMake(kScreenWidth, 0);
    }
}






#pragma mark ==== 协议 ====

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.requestState == hotState) {
        return self.commHotArr.count;
    }
    else {
        return self.commNewArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (self.requestState == hotState) {
        CommShouYeModel *hotModel = self.commHotArr[indexPath.row];
        if (hotModel.coverimg.length == 0) {
            CommHotTwoTableViewCell *cell = [self.commHotTableV dequeueReusableCellWithIdentifier:@"hotTwo" forIndexPath:indexPath];
            cell.model = hotModel;
            return cell;
        }else{
            CommHotOneTableViewCell *cell = [self.commHotTableV dequeueReusableCellWithIdentifier:@"hotOne" forIndexPath:indexPath];
            cell.model = hotModel;
            return cell;
        }
    }else
    {
        CommShouYeModel *newModel = self.commNewArr[indexPath.row];
        if (newModel.coverimg.length == 0) {
            CommNewTwoTableViewCell *cell = [self.commNewTableV dequeueReusableCellWithIdentifier:@"newTwo" forIndexPath:indexPath];
            cell.model = newModel;
            return cell;
        }else
        {
            CommNewOneTableViewCell *cell = [self.commNewTableV dequeueReusableCellWithIdentifier:@"newOne" forIndexPath:indexPath];
            cell.model = newModel;
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommXQViewController *commXQVC = [[CommXQViewController alloc]init];
    if (self.requestState == hotState) {
        CommShouYeModel *model = self.commHotArr[indexPath.row];
        //NSLog(@"%@",model.contentid);
        commXQVC.contentid = model.contentid;
    }else{
        CommShouYeModel *model = self.commNewArr[indexPath.row];
        commXQVC.contentid = model.contentid;
    }
    [self.navigationController pushViewController:commXQVC animated:YES];
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.requestState == hotState) {
        CommShouYeModel *hotModel = self.commHotArr[indexPath.row];
        if (hotModel.coverimg.length == 0) {
            return 195;
        }else{
            return 245;
        }
    }
    else
    {
        CommShouYeModel *newModel = self.commNewArr[indexPath.row];
        if (newModel.coverimg.length == 0) {
            return 195;
        }else{
            return 245;
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isMemberOfClass:[UIScrollView class]]) { // 关键
        if (scrollView.contentOffset.x/kScreenWidth == 1 && self.requestState == hotState) {
            self.segmentV.selectedSegmentIndex = 1;
            self.requestState = newState;
            [self commNewRequestData];
        }else if(scrollView.contentOffset.x/kScreenWidth == 0 && self.requestState == newState)
        {
            self.requestState = hotState;
            self.segmentV.selectedSegmentIndex = 0;
        }
    }
}


@end
