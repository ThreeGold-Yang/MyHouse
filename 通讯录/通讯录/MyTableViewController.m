//
//  MyTableViewController.m
//  通讯录
//
//  Created by lanou on 16/5/16.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "MyTableViewController.h"
#import "Contact.h"
#import "AddContactViewController.h"
#import "DIYTableViewCell.h"
#import "DetailsViewController.h"
@interface MyTableViewController ()

@property(nonatomic,strong)NSMutableArray *modeles;



@end

@implementation MyTableViewController

// 懒加载
-(NSMutableArray *)modeles
{
    if (!_modeles) {
        // 开辟空间初始化
        _modeles = [[NSMutableArray alloc]init];
        // 数据解析
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Contact" ofType:@"plist"];
        NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
        for (NSMutableDictionary *dic in arr) {
            Contact *contact = [[Contact alloc]init];
            [contact setValuesForKeysWithDictionary:dic];
            [self.modeles addObject:contact];
        }
    }
    return _modeles;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // tableView背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    // 导航栏标题
    self.navigationItem.title = @"通讯录";
    // 设置编辑按钮和添加按钮
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.rowHeight = 200;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addContact)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark --- 按钮方法
-(void)addContact
{
    AddContactViewController *addContactVC = [[AddContactViewController alloc]init];
    
    // 添加导航栏
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:addContactVC];
    
    [self  presentViewController:navi animated:YES completion:nil];
}



#pragma mark ---点击 cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:detailsVC];
    
    detailsVC.person = self.modeles[indexPath.row];
    
    [self presentViewController:navi animated:YES completion:nil];
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Contact *contact = self.modeles[section];
    NSString *tit = contact.name;
    return tit;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.modeles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Contact *contact = self.modeles[indexPath.row];
    DIYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xxx"];
    if (cell == nil) {
        cell = [[DIYTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"xxx"];
    }
    cell.Person = contact;
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.modeles removeObject:self.modeles[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        [self.modeles insertObject:@{@"xxxxx":@"name"} atIndex:indexPath.row];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.modeles insertObject:self.modeles[fromIndexPath.row] atIndex:toIndexPath.row];
    [self.modeles removeObjectAtIndex:fromIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
