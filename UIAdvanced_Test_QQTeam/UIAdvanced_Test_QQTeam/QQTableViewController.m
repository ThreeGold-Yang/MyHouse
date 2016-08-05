//
//  QQTableViewController.m
//  UIAdvanced_Test_QQTeam
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#define ScreenW  [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height

#import "QQTableViewController.h"
#import "SectionModel.h"
#import "RowModel.h"
#import "QQTableViewCell.h"
@interface QQTableViewController ()

@property(nonatomic,strong) NSMutableArray *SectionArray;
@property(nonatomic,strong) NSMutableArray *RowArray;


@end


@implementation QQTableViewController

-(NSMutableArray *)RowArray
{
    if (!_RowArray) {
        _RowArray = [NSMutableArray array];
    }
    return _RowArray;
}

-(NSMutableArray *)SectionArray
{
    if (!_SectionArray) {
        
        _SectionArray = [NSMutableArray array];
        
        NSString *path = [[NSBundle mainBundle]pathForResource:@"friends" ofType:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        for (NSDictionary *sectionDic in arr)
        {
            SectionModel *secModel = [[SectionModel alloc]init];
            
            [secModel setValuesForKeysWithDictionary:sectionDic];
            secModel.friends = [NSMutableArray array];
            NSArray *arr1 = sectionDic[@"friends"];
            for (NSDictionary *rowDic in arr1)
            {
                RowModel *rowModel = [[RowModel alloc]init];
                [rowModel setValuesForKeysWithDictionary:rowDic];
                [secModel.friends addObject:rowModel];
                [self.RowArray addObject:rowModel];
            }
            [self.SectionArray addObject:secModel];
        }
    }
    return _SectionArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStyleGrouped)];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.tableView registerClass:[QQTableViewCell class] forCellReuseIdentifier:@"qq"];
    
    self.navigationItem.title = @"好友列表";
  
}




#pragma mark ------ 分区头 -------

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionModel *secModel = self.SectionArray[section];
//    RowModel *rowModel = self.RowArray[section];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    imageV.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    imageV.tag = section + 100;
    [headerV addSubview:imageV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:tap];
    
    UIImageView *logoV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 30, 30)];
    logoV.layer.cornerRadius = 15;
    [logoV.layer setMasksToBounds:YES];
    if (secModel.isChoose == YES) {
        logoV.image = [UIImage imageNamed:@"xia"];
    }
    else
    {
        logoV.image = [UIImage imageNamed:@"you"];
    }
    [imageV addSubview:logoV];
    
    UILabel *titlelab = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 50)];
    titlelab.text = secModel.name;
    [imageV addSubview:titlelab];
    
    UILabel *peopleL = [[UILabel alloc]initWithFrame:CGRectMake(310, 10, 100, 30)];
    peopleL.text = [NSString stringWithFormat:@"%@/%ld",secModel.online,secModel.friends.count];
    [imageV addSubview:peopleL];
    
    return headerV;
}

-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UIView *view = tap.view;
    NSInteger index = view.tag - 100;
    SectionModel *secModel = self.SectionArray[index];
    if (secModel.isChoose == YES)
    {
        secModel.isChoose = NO;
    }
    else
    {
        secModel.isChoose = YES;
    }
    [self.tableView reloadData]; // 关键点
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.SectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionModel *secModel = self.SectionArray[section];
    
    if (secModel.isChoose == YES) {
        return secModel.friends.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qq" forIndexPath:indexPath];
    SectionModel *secModel = self.SectionArray[indexPath.section];
    RowModel *rowModel = secModel.friends[indexPath.row];
    cell.rowModel = rowModel;

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
