//
//  ReadViewController.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "ReadViewController.h"
#import "ReadCollectionViewCell.h"
#import "WebViewController.h"
#import "CollectionDetailsViewController.h"
@interface ReadViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)NSMutableArray *imageUrlArray; // 轮播图图片网址数组
@property(nonatomic,strong)NSMutableArray *scrollerArray;

@property(nonatomic,strong)NSMutableArray *collectionArray;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)CarouselView *carouselView;
@property(nonatomic,strong)NSDictionary *scrollerDic;
@end

@implementation ReadViewController

-(NSMutableArray *)imageUrlArray
{
    if (!_imageUrlArray) {
        _imageUrlArray = [NSMutableArray array];
    }
    return _imageUrlArray;
}

-(NSMutableArray *)scrollerArray
{
    if (!_scrollerArray) {
        _scrollerArray = [NSMutableArray array];
    }
    return _scrollerArray;
}

-(NSMutableArray *)collectionArray
{
    if (!_collectionArray) {
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self scrollerRequestData];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[ReadCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self collectionRequestData];
    
    
}



-(void)scrollerRequestData
{
    [AFNetRequestManager requestDataWithURLString:KReadURL parDic:nil finish:^(NSData *data) {
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.scrollerArray = [ScrollerModel modelConWithJSDic:jsonDic];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self creatCarouseView];
        });
        
    } error:^(NSError *error) {
       // NSLog(@"error = %@",error);
    }];
}

-(void)creatCarouseView
{
    self.imageUrlArray = [NSMutableArray array];
    for (ScrollerModel *scrModel in self.scrollerArray)
    {
        [self.imageUrlArray addObject:scrModel.img];
    }
    CarouselView *carouselView = [[CarouselView alloc]initWithFrame:CGRectMake(0, 20+KNaviH, kScreenWidth, 201) imageURLs:self.imageUrlArray];
    
    carouselView.imageClick = ^(NSInteger index)
    {
       // NSLog(@"我点击了轮播图%ld",index);
        ScrollerModel *scrollerModel = self.scrollerArray[index];
        NSString *string = scrollerModel.url;
        NSArray *arr = [string componentsSeparatedByString:@"/"];
        NSString *html = arr[3];
       // NSLog(@"%@",html);
        
        self.scrollerDic = @{@"contentid":html,@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4p0",@"version":@"3.0.2"};
        WebViewController *webVC = [[WebViewController alloc]init];
        webVC.dic = self.scrollerDic;
        webVC.ss = html;
        [self.navigationController pushViewController:webVC animated:YES];
    };
    
    [self.view addSubview:carouselView];
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((kScreenWidth-40)/3, (kScreenHeight-20-KNaviH-200-20-20)/3);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 20+KNaviH+200+10, kScreenWidth-20, kScreenHeight-20-KNaviH-200-20) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CollectionModel *model = self.collectionArray[indexPath.row];
    ReadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = 1.0;
    animation.cumulative = YES;
    animation.repeatCount = 2;
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 1.0, 0)];
    [cell.layer addAnimation:animation forKey:nil];
    cell.collectionModel = model;
    return cell;
}

-(void)collectionRequestData
{
     [AFNetRequestManager requestDataWithURLString:KReadURL parDic:nil finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        self.collectionArray = [CollectionModel modelConWithJSDic:dic];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
       // NSLog(@"error = %@",error);
    }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionModel *collectionModel = self.collectionArray[indexPath.row];
    
    CollectionDetailsViewController *collectionDetailVC = [[CollectionDetailsViewController alloc]init];
    NSDictionary *dic =  @{@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"typeid":[NSString stringWithFormat:@"%ld",collectionModel.type],@"client":@"1",@"sort":@"addtime",@"limit":@"10",@"version":@"3.0.2",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"start":@"0"};
    NSLog(@"%ld",collectionModel.type);
    collectionDetailVC.dic = dic;
    collectionDetailVC.ss = collectionModel.name;
    [self.navigationController pushViewController:collectionDetailVC animated:YES];
    
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
