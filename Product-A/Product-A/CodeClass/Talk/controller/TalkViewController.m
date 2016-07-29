//
//  TalkViewController.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "TalkViewController.h"
#import "TalkTableViewCell.h"
#import "PinLunModel.h"
@interface TalkViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property(nonatomic,strong)UIView *TopV;
@property(nonatomic,strong)UIButton *talkBackBtn;
@property(nonatomic,strong)UITextView *talkPinLunV;
@property(nonatomic,strong)UIButton *talkPinLunBtn;
@property(nonatomic,strong)UITableView *talkPinLunTableV;

@property(nonatomic,strong)NSMutableDictionary *parDic;
@property(nonatomic,strong)NSMutableArray *talkPersonArr;
@property(nonatomic,assign)NSInteger index;
@end

@implementation TalkViewController

-(NSMutableArray *)talkPersonArr
{
    if (!_talkPersonArr) {
        _talkPersonArr = [NSMutableArray array];
    }
    return _talkPersonArr;
}

-(UIView *)TopV
{
    if (!_TopV) {
        _TopV = [[UIView alloc]init];
       // _TopV.backgroundColor = [UIColor redColor];
        _TopV.frame = CGRectMake(0, 20, kScreenWidth, 40);
    }
    return _TopV;
}
-(UIButton *)talkBackBtn
{
    if (!_talkBackBtn) {
        _talkBackBtn = [[UIButton alloc]init];
        _talkBackBtn.frame = CGRectMake(0, 0, 40, 40);
        [_talkBackBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
        [_talkBackBtn addTarget:self action:@selector(talkBackBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _talkBackBtn;
}

-(UITextView *)talkPinLunV
{
    if (!_talkPinLunV) {
        _talkPinLunV = [[UITextView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 40)];
        _talkPinLunV.delegate = self;
        _talkPinLunV.returnKeyType = UIReturnKeySend;
        _talkPinLunV.backgroundColor = [UIColor redColor];
    }
    return _talkPinLunV;
}

-(UIButton *)talkPinLunBtn
{
    if (!_talkPinLunBtn) {
        _talkPinLunBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _talkPinLunBtn.frame = CGRectMake(kScreenWidth-100, 0, 50, 40);
        [_talkPinLunBtn addTarget:self action:@selector(talkPinLunBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_talkPinLunBtn setTitle:@"写评论" forState:(UIControlStateNormal)];
    }
    return _talkPinLunBtn;
}


-(UITableView *)talkPinLunTableV
{
    if (!_talkPinLunTableV) {
        _talkPinLunTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-60) style:(UITableViewStylePlain)];
        _talkPinLunTableV.dataSource = self;
        _talkPinLunTableV.delegate = self;
    }
    return _talkPinLunTableV;
}
// 状态栏白色高亮字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)talkBackBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)talkPinLunBtnAction
{
    [self.talkPinLunV becomeFirstResponder];
    
}

-(void)keyboardShow:(NSNotification *)notifi
{
   // NSLog(@"键盘出来了");
    NSLog(@"%@",notifi);
    self.talkPinLunV.frame = CGRectMake(0, 409-40, kScreenWidth, 40);
    
    
    //UIKeyboardFrameEndUserInfoKey 键盘出现后的位置
    //UIKeyboardAnimationDurationUserInfoKey 动画时间
//   CGRect newRect = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] CGRectValue];
//    [UIView animateWithDuration:[notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]animations:^{
//        // 只会走一次
//        self.talkPinLunV.transform = CGAffineTransformMakeTranslation(0, -newRect.size.height-self.talkPinLunV.height);
//
//    }];
}

-(void)keyboardHide:(NSNotification *)notifi
{
   // NSLog(@"键盘没乐");
    self.talkPinLunV.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 40);
    self.talkPinLunV.text = @"";
//   [UIView animateWithDuration:[notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
//       self.talkPinLunV.transform = CGAffineTransformIdentity;
//   }];
}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.TopV];
    [self.TopV addSubview:self.talkBackBtn];
    [self preferredStatusBarStyle];
    [self.TopV addSubview:self.talkPinLunBtn];
    [self.view addSubview:self.talkPinLunTableV];
    [self.view addSubview:self.talkPinLunV];
    
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.talkPinLunTableV registerClass:[TalkTableViewCell class] forCellReuseIdentifier:@"talkTableViewCell"];
    
    //@"553a073adfa688b70300001c
    self.index = 0;
    self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
    self.parDic = [@{@"auth":@"XZU7RH7m1861DC8Z8H8HvkTJxQMGoPLGO9zo4XDA0cWP22NdFSh9d7fo",@"client":@"1",@"contentid":self.ss,@"deviceid":@"6D4DD967-5EB2-40E2-A202-37E64F3BEA31@",@"limit":@"10",@"start":[NSString stringWithFormat:@"%ld",self.index],@"version":@"3.0.6"}mutableCopy];
    [self talkRequestData];
    
    self.talkPinLunTableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.index = 0;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self.talkPersonArr removeAllObjects];
        [self talkRequestData];
    }];
    
    self.talkPinLunTableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.index += 10;
        self.parDic[@"start"] = [NSString stringWithFormat:@"%ld",self.index];
        [self talkRequestData];
    }];

    
}

-(void)talkRequestData
{
    [RequestManager requestDataWithUrlString:KPingLunURL parDic:self.parDic finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"xxxxxxx=x==xx==x%@",dic);
        NSArray *arr = [PinLunModel modelConWithJSDic:dic];
        for (PinLunModel *model in arr) {
            [self.talkPersonArr addObject:model];
        }
        [self.talkPinLunTableV.mj_header endRefreshing];
        [self.talkPinLunTableV.mj_footer endRefreshing];
        [self.talkPinLunTableV reloadData];
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.talkPersonArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"talkTableViewCell" forIndexPath:indexPath];
    PinLunModel *model = self.talkPersonArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PinLunModel *model = self.talkPersonArr[indexPath.row];
    CGFloat H = [justHeight justHeightBy:model.content font:15 width:kScreenWidth-40] + 110;
    return H;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.talkPinLunV resignFirstResponder];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PinLunModel *model = self.talkPersonArr[indexPath.row];
        if (model.isdel) {
            [self.talkPersonArr removeObjectAtIndex:indexPath.row];
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self deleteComment:model];
        }
        [self.talkPinLunTableV reloadData];
    }
}



// textView 代理方法
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ([text isEqualToString:@"\n"]) {
        //上传评论
        [self uploadComment:textView.text];
        return  NO;
    }
   // NSLog(@"%@",text);
    return YES;
}

// 上传评论
-(void)uploadComment:(NSString *)comment
{
    // 进行网络请求
    [RequestManager requestDataWithUrlString:KAddPingLunURL parDic:@{@"auth":[UserInfoManager getUserAuth],@"content":comment,@"contentid":self.ss} finish:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.talkPinLunTableV.mj_header beginRefreshing];
        });
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
}

// 删除评论
-(void)deleteComment:(PinLunModel *)model
{
    [RequestManager requestDataWithUrlString:KDeletePingLunURL parDic:@{@"auth":[UserInfoManager getUserAuth],@"commentid":model.contentid,@"contentid":self.ss,} finish:^(NSData *data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",dic);
    } error:^(NSError *error) {
       // NSLog(@"%@",error);
    }];
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
