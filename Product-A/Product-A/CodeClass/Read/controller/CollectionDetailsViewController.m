//
//  CollectionDetailsViewController.m
//  Product-A
//
//  Created by lanou on 16/6/27.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CollectionDetailsViewController.h"
#import "CollectionDetailTableViewCell.h"
#import "CollectionDetailModel.h"
#import "ReadArticleXiangQinViewController.h"
typedef NS_ENUM(NSInteger,NewHotState)
{
    NewState,
    HotState
};

@interface CollectionDetailsViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UIScrollView *BigScrollerV;
@property(nonatomic,strong) UITableView *HotTableV;
@property(nonatomic,strong) NSMutableArray *HotArray;
@property(nonatomic,strong) UITableView *NewTableV;
@property(nonatomic,strong) NSMutableArray *NewArray;

@property(nonatomic,strong) NSMutableDictionary *muDic;
@property(nonatomic,assign) NSInteger num;

@property(nonatomic,strong) UIButton *NewBtn;
@property(nonatomic,strong) UIButton *HotBtn;
@property(nonatomic,strong) UILabel *xiahuaxian;
@property(nonatomic,assign) NewHotState State;
@end



@implementation CollectionDetailsViewController

-(NSMutableArray *)HotArray
{
    if (!_HotArray) {
        _HotArray = [NSMutableArray array];
    }
    return _HotArray;
}

-(NSMutableArray *)NewArray
{
    if (!_NewArray) {
        _NewArray = [NSMutableArray array];
    }
    return _NewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    view.backgroundColor = PKCOLOR(240, 100, 100);
    [self.view addSubview:view];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 50, 40);
    btn.tintColor = [UIColor blackColor];
    [btn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:@"u9_start"] forState:(UIControlStateNormal)];
    [view addSubview:btn];
    
    UILabel *shuxian = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 1, 40)];
    shuxian.backgroundColor = [UIColor blackColor];
    [view addSubview:shuxian];
    
    UILabel *biaoti = [[UILabel alloc]initWithFrame:CGRectMake(51, 0, 200, 40)];
    biaoti.text = self.ss;
    biaoti.textColor = [UIColor blackColor];
    [view addSubview:biaoti];
    
    self.NewBtn = [[UIButton alloc]init];
    [self.NewBtn setTitle:@"New" forState:(UIControlStateNormal)];
    self.NewBtn.frame = CGRectMake(250, 5, 40, 30);
    self.NewBtn.backgroundColor = [UIColor blackColor];
    [self.NewBtn addTarget:self action:@selector(NewchangeState) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:self.NewBtn];
    
    self.HotBtn = [[UIButton alloc]init];
    [self.HotBtn setTitle:@"Hot" forState:(UIControlStateNormal)];
    self.HotBtn.frame = CGRectMake(300, 5, 40, 30);
    self.HotBtn.backgroundColor = [UIColor grayColor];
    [self.HotBtn addTarget:self action:@selector(HotchangeState) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:self.HotBtn];
    
    self.xiahuaxian = [[UILabel alloc]initWithFrame:CGRectMake(250, 37, 40, 3)];
    self.xiahuaxian.backgroundColor = [UIColor blackColor];
    [view addSubview:self.xiahuaxian];
    
    
//    self.BigScrollerV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-61)];
//    self.BigScrollerV.backgroundColor = [UIColor whiteColor];
//    self.BigScrollerV.contentSize = CGSizeMake(kScreenWidth * 2, 0);
//    self.BigScrollerV.delegate = self; // 跟下横线保持互动状态
//    [self.view addSubview:self.BigScrollerV];
    
    self.NewTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, kScreenHeight-61) style:(UITableViewStylePlain)];
    self.NewTableV.delegate = self;
    self.NewTableV.dataSource = self;
    self.NewTableV.rowHeight = 190;
    [self.view addSubview:self.NewTableV];
    [self.NewTableV registerClass:[CollectionDetailTableViewCell class] forCellReuseIdentifier:@"CD"];
    
    self.HotTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, kScreenHeight-61) style:(UITableViewStylePlain)];
    self.HotTableV.delegate = self;
    self.HotTableV.dataSource = self;
    self.HotTableV.rowHeight = 190;
    self.HotTableV.hidden = YES;
    [self.view addSubview:self.HotTableV];
    [self.HotTableV registerClass:[CollectionDetailTableViewCell class] forCellReuseIdentifier:@"CD"];
    
    
    self.muDic = [self.dic mutableCopy];
    self.State = NewState;
    self.num = 0;
    self.muDic[@"start"] = [NSString stringWithFormat:@"%ld",self.num];
    [self requestData];
    
    // New
    self.NewTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.num = 0;
        self.muDic[@"start"] = [NSString stringWithFormat:@"%ld",self.num];
        [self.NewArray removeAllObjects];
        [self requestData];
    }];
    
    self.NewTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.num += 10;
        self.muDic[@"start"] = [NSString stringWithFormat:@"%ld",self.num];
        [self requestData];
        
    }];

    // Hot
    self.HotTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.num = 0;
        self.muDic[@"start"] = [NSString stringWithFormat:@"%ld",self.num];
        [self.HotArray removeAllObjects];
        [self requestData];
    }];
    
    
    self.HotTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.num += 10;
        self.muDic[@"start"] = [NSString stringWithFormat:@"%ld",self.num];
        [self requestData];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.State == NewState) {
        return self.NewArray.count;
    }
    else {
        return self.HotArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    CollectionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CD" forIndexPath:indexPath];
    if (self.State == NewState) {
        CollectionDetailModel *model  = self.NewArray[indexPath.row];
        cell.model = model;
    }
    else if(self.State == HotState)
    {
        CollectionDetailModel *model  = self.HotArray[indexPath.row];
        cell.model = model;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReadArticleXiangQinViewController *readXiangQinVC = [[ReadArticleXiangQinViewController alloc]init];
    if (self.State == NewState) {
        CollectionDetailModel *model  = self.NewArray[indexPath.row];
        readXiangQinVC.ss = model.myID;
        readXiangQinVC.coverimg = model.coverimg;
    }
    else if(self.State == HotState)
    {
        CollectionDetailModel *model  = self.HotArray[indexPath.row];
        readXiangQinVC.ss = model.myID;
        readXiangQinVC.coverimg = model.coverimg;
    }
    [self.navigationController pushViewController:readXiangQinVC animated:YES];

}


-(void)requestData
{
    if (self.State == NewState) {
        self.muDic[@"sort"] = @"addtime";
    }
    else
    {
        self.muDic[@"sort"] = @"hot";
    }
    [RequestManager requestDataWithUrlString:KDetailsURL parDic:self.muDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arr = [CollectionDetailModel modelConWithJsonDic:dic];
            if (self.State == NewState) {
                for (CollectionDetailModel *model in arr) {
                    [self.NewArray addObject:model];
                }
                [self.NewTableV reloadData];
                [self.NewTableV.mj_header endRefreshing];
                [self.NewTableV.mj_footer endRefreshing];
            }
            else if(self.State == HotState)
            {
                for (CollectionDetailModel *model  in arr) {
                    [self.HotArray addObject:model];
                }
                [self.HotTableV reloadData];
                [self.HotTableV.mj_header endRefreshing];
                [self.HotTableV.mj_footer endRefreshing];
            }

            } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)NewchangeState
{
    self.State = NewState;
    self.HotBtn.backgroundColor = [UIColor grayColor];
    self.NewBtn.backgroundColor = [UIColor blackColor];
    self.xiahuaxian.frame = CGRectMake(250, 37, 40, 3);
    self.BigScrollerV.contentOffset = CGPointMake(0, 0);
    self.HotTableV.hidden = YES;
    [self requestData];
}

-(void)HotchangeState
{
    self.State = HotState;
    self.HotBtn.backgroundColor = [UIColor blackColor];
    self.NewBtn.backgroundColor = [UIColor grayColor];
    self.xiahuaxian.frame = CGRectMake(300, 37, 40, 3);
    self.HotTableV.hidden = NO;
    [self requestData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

@end
