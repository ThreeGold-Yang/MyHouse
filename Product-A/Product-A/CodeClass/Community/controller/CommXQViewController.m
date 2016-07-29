//
//  CommXQViewController.m
//  Product-A
//
//  Created by lanou on 16/7/6.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "CommXQViewController.h"
#import "CommXQAuthModel.h"
#import "CommXQTalkModel.h"
#import "CommXQTalkTableViewCell.h"
@interface CommXQViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NSMutableDictionary *parDic;
@property(nonatomic,strong) NSMutableArray *commXQTalkModelArr;
@property(nonatomic,strong) NSString *html;


@property(nonatomic,strong) UITableView *commXQTableView;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UIImageView *authImageV;
@property(nonatomic,strong) UILabel *authL;
@property(nonatomic,strong) UILabel *dayL;

@property(nonatomic,strong) UIView *headV;
@property(nonatomic,strong) UIButton *justlouzhuBtn;
@property(nonatomic,strong) UIButton *shunxuBtn;
@property(nonatomic,strong) UIButton *remenBtn;

@property(nonatomic,strong) CommXQAuthModel *authModel;


//contentid=5773245c01334dae16284156&client=1&deviceid=63A94D37-33F9-40FF-9EBB-481182338873&auth=Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0&version=3.0.2








@end

@implementation CommXQViewController
#pragma mark ==== 懒加载 ====

-(NSMutableArray *)commXQTalkModelArr
{
    if (!_commXQTalkModelArr) {
        _commXQTalkModelArr = [NSMutableArray array];
    }
    return _commXQTalkModelArr;
}


#pragma mark ==== ViewWill ====
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.parDic = [@{@"contentid":self.contentid,@"client":@"1",@"deviceid":@"63A94D37-33F9-40FF-9EBB-481182338873",@"auth":@"Wc06FCrkoq1DCMVzGMTikDJxQ8bm3Mrm2NpT9qWjwzcWP23tBKQx1c4P0",@"version":@"3.0.2"} mutableCopy];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTableView];
    [self.commXQTableView registerClass:[CommXQTalkTableViewCell class] forCellReuseIdentifier:@"commXQCell"];
    
    
    [self requestData];

}


#pragma mark ==== 方法 ====
-(void)requestData
{
    [RequestManager requestDataWithUrlString:KHuaTiXiangQinUrl parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSDictionary *postsinfoDic = dataDic[@"postsinfo"];
        NSString *htmlString = postsinfoDic[@"html"];
        self.html = [NSString importStyleWithHtmlString:htmlString];
        self.authModel = [CommXQAuthModel modelWithJsonDic:dic];
        self.commXQTalkModelArr = [CommXQTalkModel modelWithJsonDic:dic];
        [self.commXQTableView reloadData];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

-(void)creatTableView
{
    self.commXQTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60) style:(UITableViewStylePlain)];
    self.commXQTableView.backgroundColor = [UIColor whiteColor];
    self.commXQTableView.dataSource = self;
    self.commXQTableView.delegate = self;
    [self.view addSubview:self.commXQTableView];
}

#pragma mark ==== 协议 ====

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commXQTalkModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommXQTalkModel *model = self.commXQTalkModelArr[indexPath.row];
    CommXQTalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commXQCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommXQTalkModel *model = self.commXQTalkModelArr[indexPath.row];
    CGFloat H = [justHeight justHeightBy:model.content font:15 width:kScreenWidth-40];
    return H+85;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    self.headV = [[UIView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-110)];
    self.headV.backgroundColor = [UIColor whiteColor];
    
    self.titleL = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, kScreenWidth-40, 50)];
    self.titleL.numberOfLines = 3;
    self.titleL.font = [UIFont systemFontOfSize:20];
    self.titleL.text = self.authModel.title;
    [self.headV addSubview:self.titleL];
    
    self.authImageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 95, 50, 50)];
    [self.authImageV sd_setImageWithURL:[NSURL URLWithString:self.authModel.icon] placeholderImage:placeHoldImageURL completed:nil];
    [self.headV addSubview:self.authImageV];
    
    self.authL = [[UILabel alloc]initWithFrame:CGRectMake(80, 105, 100, 30)];
    self.authL.text = self.authModel.uname;
    self.authL.textAlignment = 1;
    self.authL.alpha = 0.5;
    [self.headV addSubview:self.authL];
    
    self.dayL = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-170, 105, 150, 30)];
    self.dayL.textAlignment = 1;
    self.dayL.text = self.authModel.addtime_f;
    self.dayL.alpha = 0.5;
    [self.headV addSubview:self.dayL];
    
    UIWebView *web = [[UIWebView alloc]init];
    web.frame = CGRectMake(15, 155,kScreenWidth-30, kScreenHeight-265);
    [web loadHTMLString:self.html baseURL:[NSURL fileURLWithPath:[NSBundle mainBundle].bundlePath]];
    web.backgroundColor = [UIColor whiteColor];
    [self.headV addSubview:web];
    
    self.justlouzhuBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.justlouzhuBtn.frame = CGRectMake(10, kScreenHeight-100, 80, 30);
    self.justlouzhuBtn.backgroundColor = [UIColor blackColor];
    [self.justlouzhuBtn setTitle:@"只看楼主" forState:(UIControlStateNormal)];
    [self.headV addSubview:self.justlouzhuBtn];
    
    self.shunxuBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.shunxuBtn.frame = CGRectMake(100, kScreenHeight-100, kScreenWidth-200, 30);
    self.shunxuBtn.backgroundColor = [UIColor blackColor];
    [self.shunxuBtn setTitle:@"顺序查看评论" forState:(UIControlStateNormal)];
    [self.headV addSubview:self.shunxuBtn];
    
    self.remenBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    self.remenBtn.frame = CGRectMake(kScreenWidth-90, kScreenHeight-100, 80, 30);
    self.remenBtn.backgroundColor = [UIColor blackColor];
    [self.remenBtn setTitle:@"热门评论" forState:(UIControlStateNormal)];
    [self.headV addSubview:self.remenBtn];
    return self.headV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kScreenHeight-60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.commXQTableView) {
        NSLog(@"%f",scrollView.contentOffset.y);
        
        CGFloat sectionHeaderHeight = kScreenHeight - 100;
        if (scrollView.contentOffset.y<0) {
            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        if (scrollView.contentOffset.y == 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        } else if (scrollView.contentOffset.y<=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
    }
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
