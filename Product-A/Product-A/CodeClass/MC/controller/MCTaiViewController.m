//
//  MCTaiViewController.m
//  Product-A
//
//  Created by lanou on 16/7/2.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "MCTaiViewController.h"
#import "MCLunBoModel.h"
#import "MCJiHeModel.h"
#import "MCBiaoModel.h"
#import "McJiHeCollectionViewCell.h"
#import "McBiaoTableViewCell.h"
#import "MCXiangQinViewController.h"
@interface MCTaiViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UIImageView *jumpImageView;

@property(nonatomic,strong) UITableView *mcTaiTableV;
@property(nonatomic,strong) CarouselView *carouselV;
@property(nonatomic,strong) UICollectionView *mcJiheV;

@property(nonatomic,strong) NSDictionary *parDic;
@property(nonatomic,strong) NSMutableArray *mcLunBoArr;
@property(nonatomic,strong) NSMutableArray *mcLunImageUrlArr;
@property(nonatomic,strong) NSMutableArray *mcJiHeArr;
@property(nonatomic,strong) NSMutableArray *mcBiaoArr;



@end

@implementation MCTaiViewController

#pragma mark ===== 懒加载 =====
-(NSMutableArray *)mcLunBoArr
{
    if (!_mcLunBoArr) {
        _mcLunBoArr = [NSMutableArray array];
    }
    return _mcLunBoArr;
}
-(NSMutableArray *)mcLunImageUrlArr
{
    if (!_mcLunImageUrlArr) {
        _mcLunImageUrlArr = [NSMutableArray array];
    }
    return _mcLunImageUrlArr;
}
-(NSMutableArray *)mcJiHeArr
{
    if (!_mcJiHeArr) {
        _mcJiHeArr = [NSMutableArray array];
    }
    return _mcJiHeArr;
}
-(NSMutableArray *)mcBiaoArr
{
    if (!_mcBiaoArr) {
        _mcBiaoArr = [NSMutableArray array];
    }
    return _mcBiaoArr;
}

#pragma mark ===== 外观设置 =====

//-(UIImageView *)jumpImageView
//{
//    if (!_jumpImageView) {
//        _jumpImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-90, 20, 50, 40)];
//        _jumpImageView.image = [UIImage imageNamed:@"d0.png"];
//    }
//    return _jumpImageView;
//}

-(UITableView *)mcTaiTableV
{
    if (!_mcTaiTableV) {
        _mcTaiTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60) style:(UITableViewStyleGrouped)];
        _mcTaiTableV.dataSource = self;
        _mcTaiTableV.delegate = self;
        _mcTaiTableV.rowHeight = 120;
    }
    return _mcTaiTableV;
}

-(UICollectionView *)mcJiheV
{
    if (!_mcJiheV) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(110, 150);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        _mcJiheV = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 160, kScreenWidth-20, 130) collectionViewLayout:layout];
        _mcJiheV.backgroundColor = [UIColor whiteColor];
        _mcJiheV.dataSource = self;
        _mcJiheV.delegate = self;
    }
    return _mcJiheV;
}


#pragma mark ==== ViewWill ====
//-(void)viewWillAppear:(BOOL)animated
//{
//    if ([VideoManager shareInstance].isPlay == YES) {
//        [self jumpImageStart];
//    }
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mcTaiTableV];
    [self.view addSubview:self.jumpImageView];
    self.parDic = @{@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@" auth":@"",@"version":@"3.0.2"};
    [self mcLunBoRequest];
    [self mcJiHeRequest];
    [self mcBiaoRequest];
    [self.mcJiheV registerClass:[McJiHeCollectionViewCell class] forCellWithReuseIdentifier:@"mcjihe"];
    
    UIImage *image = [UIImage imageNamed:@"mm15.jpg"];
    [YYClipImageTool addToCurrentView:self.view clipImage:image backgroundImage:nil];
    
}

#pragma mark ===== 方法 =====
-(void)mcLunBoRequest
{
    [RequestManager requestDataWithUrlString:KPOSTURL parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.mcLunBoArr = [MCLunBoModel mcLunBomodelConfigureWithJsonDic:dic];
        
        //创建轮播图
        for (MCLunBoModel *model in self.mcLunBoArr) {
            [self.mcLunImageUrlArr addObject:model.img];
        }
        self.carouselV = [[CarouselView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150) imageURLs:self.mcLunImageUrlArr];
        [self lunBoJumpMCXQ];
        [self.mcTaiTableV reloadData];
    } error:^(NSError *error) {
        //NSLog(@"error === %@",error);
    }];
}

-(void)mcJiHeRequest
{
    [RequestManager requestDataWithUrlString:KPOSTURL parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.mcJiHeArr = [MCJiHeModel mcJiHemodelConfigureWithJsonDic:dic];
        [self.mcJiheV reloadData]; //关键
       // [self.mcTaiTableV reloadData]; //关键
    } error:^(NSError *error) {
       // NSLog(@"error===%@",error);
    }];

}

-(void)mcBiaoRequest
{
    [RequestManager requestDataWithUrlString:KPOSTURL parDic:self.parDic finish:^(NSData *data) {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.mcBiaoArr = [MCBiaoModel mcBiaoModelConfigureWithJsonDic:dic];
        [self.mcTaiTableV reloadData];
        //[self.mcJiheV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}


-(void)lunBoJumpMCXQ
{
    __weak MCTaiViewController *mySelf = self;
    mySelf.carouselV.imageClick = ^(NSInteger index)
    {
        MCLunBoModel *model = mySelf.mcLunBoArr[index];
        NSString *string = model.url;
        NSArray *array = [string componentsSeparatedByString:@"/"];
        NSString *ss = array[3];
        MCXiangQinViewController *MCXQVC = [[MCXiangQinViewController alloc]init];
        MCXQVC.urlID = ss;
        [mySelf.navigationController pushViewController:MCXQVC animated:YES];
    };
}

//-(void)jumpImageStart
//{
//    NSMutableArray *imageArr = [NSMutableArray array];
//    for (int i=0; i<5; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"d%d.png",i]];
//        [imageArr addObject:image];
//    }
//    self.jumpImageView.animationImages = imageArr;
//    self.jumpImageView.animationRepeatCount = FLT_MAX;
//    self.jumpImageView.animationDuration = 1;
//    [self.jumpImageView startAnimating];
//    
//}



#pragma mark ====协议====
// 表视图
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
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, 300)];
    headV.backgroundColor = [UIColor whiteColor];
    [headV addSubview:self.carouselV];
    [headV addSubview:self.mcJiheV];
    return headV;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.mcBiaoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    McBiaoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mcTaiShouYe"];
    if (cell == nil) {
        cell = [[McBiaoTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"mcTaiShouYe"];
    }
    MCBiaoModel *model = self.mcBiaoArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MCXiangQinViewController *mcXQVC = [[MCXiangQinViewController alloc]init];
    MCBiaoModel *model = self.mcBiaoArr[indexPath.row];
    mcXQVC.urlID = model.radioid;
    [self.navigationController pushViewController:mcXQVC animated:YES];
}



// 集合视图
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.mcJiHeArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    McJiHeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mcjihe" forIndexPath:indexPath];
    MCJiHeModel *model = self.mcJiHeArr[indexPath.row];
    cell.model = model;
    cell.backgroundColor = [UIColor blackColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MCJiHeModel *model = self.mcJiHeArr[indexPath.row];
    MCXiangQinViewController *MCDetailVC = [[MCXiangQinViewController alloc]init];
    MCDetailVC.urlID = model.radioid;
    [self.navigationController pushViewController:MCDetailVC animated:YES];
}




@end
