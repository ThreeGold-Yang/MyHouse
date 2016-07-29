//
//  MCXiangQinViewController.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCXiangQinViewController.h"
#import "MCXQShangBanModel.h"
#import "MCXQXiaBanModel.h"
#import "MCXQTableViewCell.h"
#import "MCPlayViewController.h"
@interface MCXiangQinViewController ()<UITableViewDataSource,UITableViewDelegate>



@property(nonatomic,strong) UITableView *mcXQTableV;
@property(nonatomic,strong) UIImageView *mcXQTopImageV;
@property(nonatomic,strong) UIImageView *mcXQPersonImageV;
@property(nonatomic,strong) UILabel *mcXQPersonL;
@property(nonatomic,strong) UIImageView *mcXQWifiV;
@property(nonatomic,strong) UILabel *mcXQshoutingNumL;
@property(nonatomic,strong) UILabel *mcXQPersonContentL;

@property(nonatomic,strong) NSMutableArray *mcXQshangbanArr;
@property(nonatomic,strong) NSMutableArray *mcXQxiabanArr;

@property(nonatomic,strong) NSMutableDictionary *dic;
@end

@implementation MCXiangQinViewController
#pragma mark ==== 懒加载 ====
-(NSMutableArray *)mcXQshangbanArr
{
    if (!_mcXQshangbanArr) {
        _mcXQshangbanArr = [NSMutableArray array];
    }
    return _mcXQshangbanArr;
}

-(NSMutableArray *)mcXQxiabanArr
{
    if (!_mcXQxiabanArr) {
        _mcXQxiabanArr = [NSMutableArray array];
    }
    return _mcXQxiabanArr;
}
#pragma mark ==== 外观 ====

-(UIImageView *)jumpImageV
{
    if (!_jumpImageV) {
        _jumpImageV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-90, 20,50 , 40)];
        _jumpImageV.image = [UIImage imageNamed:@"d0.png"];
    }
    return _jumpImageV;
}

-(UITableView *)mcXQTableV
{
    if (!_mcXQTableV) {
        _mcXQTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60) style:(UITableViewStyleGrouped)];
        _mcXQTableV.backgroundColor = [UIColor whiteColor];
        _mcXQTableV.dataSource =self;
        _mcXQTableV.delegate = self;
        _mcXQTableV.rowHeight = 104;
    }
    return _mcXQTableV;
}

-(UIImageView *)mcXQTopImageV
{
    if (!_mcXQTopImageV) {
        _mcXQTopImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, (kScreenHeight-60)/4)];
        _mcXQTopImageV.backgroundColor = [UIColor redColor];
    }
    return _mcXQTopImageV;
}

-(UIImageView *)mcXQPersonImageV
{
    if (!_mcXQPersonImageV) {
        _mcXQPersonImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20,(kScreenHeight-60)/4 +20, 60, 60)];
        _mcXQPersonImageV.backgroundColor = [UIColor redColor];
    }
    return _mcXQPersonImageV;
}

-(UILabel *)mcXQPersonL
{
    if (!_mcXQPersonL) {
        _mcXQPersonL = [[UILabel alloc]initWithFrame:CGRectMake(90,(kScreenHeight-60)/4 +35, 150, 30)];
        _mcXQPersonL.text = @"123";
    }
    return _mcXQPersonL;
}

-(UIImageView *)mcXQWifiV
{
    if (!_mcXQWifiV) {
        _mcXQWifiV = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-120,(kScreenHeight-60)/4 +30, 20, 20)];
        _mcXQWifiV.image = [UIImage imageNamed:@"WiFi"];
    }
    return _mcXQWifiV;
}

-(UILabel *)mcXQshoutingNumL
{
    if (!_mcXQshoutingNumL) {
        _mcXQshoutingNumL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100,(kScreenHeight-60)/4 +30, 100, 20)];
        _mcXQshoutingNumL.text = @"4546546";
    }
    return _mcXQshoutingNumL;
}

-(UILabel *)mcXQPersonContentL
{
    if (!_mcXQPersonContentL) {
        _mcXQPersonContentL = [[UILabel alloc]initWithFrame:CGRectMake(20,(kScreenHeight-60)/4 +100, kScreenWidth-40, 30)];
        _mcXQPersonContentL.text = @"dsadsadasdas";
    }
    return _mcXQPersonContentL;
}

#pragma mark ==== 方法 ====

-(void)mcXQshangbanRequestData
{
    
    //self.dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"client",@"1",@"deviceid",@"63A94D37-33-33F9-40FF-9EBB-481182338873",@"radioid",self.urlID,@"version",@"3.0.4", nil];
    self.dic = [@{@"client":@"1",@"deviceid":@"63A94D37-33-33F9-40FF-9EBB-481182338873",@"radioid":self.urlID,@"version":@"3.0.4"}mutableCopy];
    [RequestManager requestDataWithUrlString:KMCDetailsURL parDic:self.dic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.mcXQshangbanArr = [MCXQShangBanModel mcXQShangBanModelWithJsonDic:dic];
        for (MCXQShangBanModel *model in self.mcXQshangbanArr) {
            [self.mcXQTopImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:placeHoldImageURL completed:nil];
            [self.mcXQPersonImageV sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:placeHoldImageURL completed:nil];
            self.mcXQPersonL.text = model.uname;
            self.mcXQshoutingNumL.text = [NSString stringWithFormat:@"%@",model.musicvisitnum];
            self.mcXQPersonContentL.text = model.desc;
        }
        
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

-(void)mcXQxiabanRequestData
{
    //NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"client",@"1",@"deviceid",@"63A94D37-33-33F9-40FF-9EBB-481182338873",@"radioid",self.urlID,@"version",@"3.0.4" ,nil];
    
    self.dic = [@{@"client":@"1",@"deviceid":@"63A94D37-33-33F9-40FF-9EBB-481182338873",@"radioid":self.urlID,@"version":@"3.0.4"} mutableCopy];
    //NSLog(@"%@",self.urlID);
    [RequestManager requestDataWithUrlString:KMCDetailsURL parDic:self.dic finish:^(NSData *data) {
        NSDictionary *dicc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.mcXQxiabanArr = [MCXQXiaBanModel mcXQxiaBanModelListWithJSONDic:dicc];
        [self.mcXQTableV reloadData];
    } error:^(NSError *error) {
      //  NSLog(@"%@",error);
    }];

}

-(void)jumpStart
{
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"d%d.png",i]];
        [imageArr addObject:image];
    }
    self.jumpImageV.animationImages = imageArr;
    self.jumpImageV.animationRepeatCount = FLT_MAX;
    self.jumpImageV.animationDuration = 1;
    [self.jumpImageV startAnimating];
}



#pragma mark === viewWill ===

-(void)viewWillAppear:(BOOL)animated
{
    if ([VideoManager shareInstance].isPlay == YES) {
        [self jumpStart];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mcXQTableV];
    [self.view addSubview:self.jumpImageV];
    [self mcXQshangbanRequestData];
    [self mcXQxiabanRequestData];
    
    [self.mcXQTableV registerClass:[MCXQTableViewCell class] forCellReuseIdentifier:@"mcXQ"];
    
}
#pragma mark ==== 协议 ====
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.mcXQxiabanArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MCXQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mcXQ" forIndexPath:indexPath];
    MCXQXiaBanModel *model = self.mcXQxiabanArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCPlayViewController *mcPlayerVC = [[MCPlayViewController alloc]init];
    [VideoManager shareInstance].Array = self.mcXQxiabanArr;
    [VideoManager shareInstance].index = indexPath.row;
    
    for (MCXQXiaBanModel *model in self.mcXQxiabanArr) {
        [mcPlayerVC.musicUrlArr addObject:model.musicUrl];
    }
    

    
    [self.navigationController pushViewController:mcPlayerVC animated:YES];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCXQXiaBanModel *model = self.mcXQxiabanArr[indexPath.row];
    model.thereIs = NO;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 300;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    headV.backgroundColor = [UIColor whiteColor];
    [headV addSubview:self.mcXQTopImageV];
    [headV addSubview:self.mcXQPersonImageV];
    [headV addSubview:self.mcXQPersonL];
    [headV addSubview:self.mcXQWifiV];
    [headV addSubview:self.mcXQshoutingNumL];
    [headV addSubview:self.mcXQPersonContentL];
    return headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}



@end
