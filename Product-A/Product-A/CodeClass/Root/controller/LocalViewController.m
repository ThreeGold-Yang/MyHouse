//
//  LocalViewController.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LocalViewController.h"
#import "LocalTableViewCell.h"
#import "MCPlayViewController.h"
#import "LocalModel.h"


typedef NS_ENUM(NSInteger,EditType) {
    edittingType,
    normalType
};
@interface LocalViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *DidDownMusicTableV;
@property(nonatomic,strong) UIView *TopV;
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton *editBtn;

@property(nonatomic,strong) UIView *downV;
@property(nonatomic,strong) UIButton *chooseAllBtn;
@property(nonatomic,strong) UIButton *deleteBtn;

@property(nonatomic,assign) EditType editType;
@property(nonatomic,assign) NSInteger index;
@end

@implementation LocalViewController

-(UITableView *)DidDownMusicTableV
{
    if (!_DidDownMusicTableV) {
        _DidDownMusicTableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 61, kScreenWidth, kScreenHeight) style:(UITableViewStylePlain)];
        _DidDownMusicTableV.delegate = self;
        _DidDownMusicTableV.dataSource = self;
    }
    return _DidDownMusicTableV;
}
// 状态栏白色高亮字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(UIView *)TopV
{
    if (!_TopV) {
        _TopV = [[UIView alloc]init];
        _TopV.frame = CGRectMake(0, 20, kScreenWidth, 40);
    }
    return _TopV;
}
-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        _backBtn.frame = CGRectMake(0, 0, 50, 40);
        [_backBtn setImage:[UIImage imageNamed:@"navigationbar_back"] forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
}

-(UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        if (self.editType == normalType) {
            [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        }else{
            [_editBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        }
        
        [_editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        _editBtn.frame = CGRectMake(kScreenWidth-50, 0, 50, 40);
    }
    return _editBtn;
}

-(UIView *)downV
{
    if (!_downV) {
        _downV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight+40, kScreenWidth, 40)];
        _downV.backgroundColor = [UIColor redColor];
    }
    return _downV;
}

-(UIButton *)chooseAllBtn
{
    if (!_chooseAllBtn) {
        _chooseAllBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_chooseAllBtn setTitle:@"全部选择" forState:(UIControlStateNormal)];
        _chooseAllBtn.frame =CGRectMake(0, 0, 80, 40);
        [_chooseAllBtn addTarget:self action:@selector(chooseAllBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _chooseAllBtn;
}

-(UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        _deleteBtn.frame = CGRectMake(kScreenWidth-80, 0, 80, 40);
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editType = normalType;
    [self preferredStatusBarStyle];
    [self.view addSubview:self.TopV];
    [self.TopV addSubview:self.backBtn];
    [self.TopV addSubview:self.editBtn];
    [self.view addSubview:self.DidDownMusicTableV];
    [self.view addSubview:self.downV];
    [self.downV addSubview:self.chooseAllBtn];
    [self.downV addSubview:self.deleteBtn];
    [self.DidDownMusicTableV registerClass:[LocalTableViewCell class] forCellReuseIdentifier:@"DidDownMusicCell"];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)editBtnAction
{
    
    if (self.array.count== 0 && [self.editBtn.titleLabel.text isEqualToString:@"编辑"]) {
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"请下载数据！！！！" message:@"没有数据可以操作" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alter addAction:action];
        [self presentViewController:alter animated:YES completion:nil];
    }else{
        if ([self.chooseAllBtn.titleLabel.text isEqualToString:@"取消全选"] && [self.editBtn.titleLabel.text isEqualToString:@"完成"]) {
            self.downV.hidden = YES;
            [self.editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        }else{
            NSArray *arr = self.DidDownMusicTableV.visibleCells;
            if (self.editType == normalType) {
                [self.editBtn setTitle:@"完成" forState:(UIControlStateNormal)];
                self.editType = edittingType;
                self.downV.frame = CGRectMake(0, kScreenHeight-40, kScreenWidth, 40);
                for (LocalTableViewCell *cell in arr) {
                    cell.chooseBtn.hidden = NO;
                }
            }
            else
            {
                self.editType = normalType;
                [self.editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
                self.downV.frame = CGRectMake(0, kScreenHeight+40, kScreenWidth, 40);
                for (LocalTableViewCell *cell in arr) {
                    cell.chooseBtn.hidden = YES;
                }
            }
            
        }
    }
    
    
}

-(void)chooseAllBtnAction
{
    if ([self.chooseAllBtn.titleLabel.text isEqualToString:@"全部选择"]) {
        [self.chooseAllBtn setTitle:@"取消全选" forState:(UIControlStateNormal)];
        for (NSInteger i = 0; i<self.array.count; i++)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            LocalTableViewCell *cell = [self.DidDownMusicTableV cellForRowAtIndexPath:path];
            cell.isChoose = YES;
            [self.DidDownMusicTableV reloadData];
        }
    }else{
        [self.chooseAllBtn setTitle:@"全部选择" forState:(UIControlStateNormal)];
        for (NSInteger i = 0; i<self.array.count; i++) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            LocalTableViewCell *cell = [self.DidDownMusicTableV cellForRowAtIndexPath:path];
            cell.isChoose = NO;
            [self.DidDownMusicTableV reloadData];
        }
    }
}

-(void)deleteBtnAction
{
    if ([self.chooseAllBtn.titleLabel.text isEqualToString:@"全部选择"]) {
        for (NSInteger i = self.array.count - 1; i>=0; i--) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
            LocalTableViewCell *cell = [self.DidDownMusicTableV cellForRowAtIndexPath:path];
            if (cell.isChoose == YES) {
                [self.array removeObjectAtIndex:i];
                [self.DidDownMusicTableV deleteRowsAtIndexPaths:@[path] withRowAnimation:(UITableViewRowAnimationLeft)];
            }
        }
    }else{
        [self.array removeAllObjects];
        [self.DidDownMusicTableV reloadData];
    }
    
}



-(void)changeChooseAction:(UIButton *)btn
{
    LocalTableViewCell *cell = (LocalTableViewCell *)btn.superview.superview;
    NSIndexPath *indexPath = [self.DidDownMusicTableV indexPathForCell:cell];
    self.index = indexPath.row;
    if (cell.isChoose == NO) {
        [btn setBackgroundImage:[UIImage imageNamed:@"you"] forState:(UIControlStateNormal)];
        cell.isChoose = YES;
    }else{
        cell.isChoose = NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"me"] forState:(UIControlStateNormal)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (self.array.count == 0) {
        return 1;
    }
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (self.array.count == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:1 reuseIdentifier:@"NoCell"];
        }
        cell.textLabel.text = @"                               没有数据";
        return cell;
    }
    else{
        LocalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DidDownMusicCell" forIndexPath:indexPath];
        cell.titleL.text = self.array[indexPath.row][0];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:self.array[indexPath.row][2]]];
        
        if (self.editType == normalType) {
            cell.chooseBtn.hidden = YES;
        }else{
            cell.chooseBtn.hidden = NO;
        }
        if (cell.isChoose == YES) {
            [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"you"] forState:(UIControlStateNormal)];
        }else{
            [cell.chooseBtn setBackgroundImage:[UIImage imageNamed:@"me"] forState:(UIControlStateNormal)];
        }
        
        
        [cell.chooseBtn addTarget:self action:@selector(changeChooseAction:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.array.count == 0) {
        
    }
    else{
        MCPlayViewController *mcPlayVC = [[MCPlayViewController alloc]init];
        mcPlayVC.localArr = self.array;
        mcPlayVC.localIndex = indexPath.row;
        
        [VideoManager shareInstance].Array = self.array;
        [VideoManager shareInstance].index = indexPath.row;
        [self presentViewController:mcPlayVC animated:YES completion:nil];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.array.count != 0)
    {
        return 61;
    }
    else{
        return kScreenHeight-61;
    }
}
@end
