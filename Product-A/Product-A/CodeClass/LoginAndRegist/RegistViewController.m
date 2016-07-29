//
//  RegistViewController.m
//  Product-A
//
//  Created by lanou on 16/7/1.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,assign)NSInteger gender;
@property(nonatomic,strong)UIImage *uploadImage;
@end

@implementation RegistViewController
// 状态栏白色高亮字体
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self preferredStatusBarStyle];
    
    UIView *horizontal = [[UIView alloc]initWithFrame:CGRectMake(0, 20+KNaviH+1, kScreenWidth, 1)];
    horizontal.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:horizontal];
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(40, 20, 1, KNaviH)];
    vertical.backgroundColor = PKCOLOR(100, 100, 100);
    [self.view addSubview:vertical];
    
    self.uploadImage = [UIImage imageNamed:@"bj8.jpg"];
    
}

#pragma mark ==== 方法 ====
- (IBAction)regBtnAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)regManAction:(id)sender
{
    self.gender = 1;
    [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.regWomenBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}
- (IBAction)regWomenBtnAction:(id)sender
{
    self.gender = 2;
   [sender setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [self.regManBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
}
- (IBAction)wanchengzhuceBtnAction:(id)sender
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    // 如果请求出现 content-type相关错误，用两种方案解决
    // 应该适用于一切出现 content-type 相关错误的案例。但请求成功后返回的值被转成NSData，可读性不强
    // setWithObject：接具体出现的 content-type 类型错误，返回信息更全面
    // manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-javascript"];

    [manager POST:kRegistUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(self.uploadImage) name:@"iconfile" fileName:@"uploadheadImage.png" mimeType:@"image/png"];
        [formData appendPartWithFormData:[self.youxiangTF.text dataUsingEncoding:NSUTF8StringEncoding] name:@"email"];
        [formData appendPartWithFormData:[self.nichengTF.text dataUsingEncoding:NSUTF8StringEncoding] name:@"uname"];
        [formData appendPartWithFormData:[self.mimaTF.text dataUsingEncoding:NSUTF8StringEncoding] name:@"passwd"];
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%ld",self.gender] dataUsingEncoding:NSUTF8StringEncoding] name:@"gender"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
       // NSLog(@"%lf",1.0*uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"%@",dic);
       // NSLog(@"%@",[dic[@"data"] valueForKey:@"msg"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // NSLog(@"错误=========%@",error);
    }];
    

}
- (IBAction)openXiangCe:(id)sender
{
    [self creatAlterView];
}

-(void)creatAlterView
{
    UIToolbar *zhedangV = [[UIToolbar alloc]init];
    zhedangV.frame = CGRectMake(0, 60, kScreenWidth, kScreenHeight-60);
    zhedangV.barStyle = 1;
    [self.view addSubview:zhedangV];
    
    UIButton *chooseXiangceBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];;
    chooseXiangceBtn.frame = CGRectMake(100, 400, kScreenWidth-200, 30);
    [chooseXiangceBtn setTitle:@"打开相册" forState:(UIControlStateNormal)];
    chooseXiangceBtn.backgroundColor = [UIColor blackColor];
    [chooseXiangceBtn addTarget:self action:@selector(chooseXiangceBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [zhedangV addSubview:chooseXiangceBtn];
    
    UIButton *chooseXiangjiBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];;
    chooseXiangjiBtn.frame = CGRectMake(100, 450, kScreenWidth-200, 30);
    [chooseXiangjiBtn setTitle:@"打开相机" forState:(UIControlStateNormal)];
    chooseXiangjiBtn.backgroundColor = [UIColor blackColor];
    [chooseXiangjiBtn addTarget:self action:@selector(chooseXiangjiBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [zhedangV addSubview:chooseXiangjiBtn];
    
    UIButton *quxiaoBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    quxiaoBtn.frame = CGRectMake(100, 500, kScreenWidth-200, 30);
    [quxiaoBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    quxiaoBtn.backgroundColor = [UIColor blackColor];
    [quxiaoBtn addTarget:self action:@selector(hidehedangV:) forControlEvents:(UIControlEventTouchUpInside)];
    [zhedangV addSubview:quxiaoBtn];

}

-(void)hidehedangV:(UIButton *)btn
{
    UIToolbar *view = (UIToolbar *)btn.superview;
    view.hidden = YES;
}

-(void)chooseXiangceBtnAction:(UIButton *)btn
{
    // 默认只打开相册
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *pc = [[UIImagePickerController alloc]init];
        pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pc.allowsEditing = YES;
        pc.delegate = self;
        [self presentViewController:pc animated:YES completion:^{
           // NSLog(@"移除控件");
        }];
    }else{
       // NSLog(@"没有相册");
    }
}

-(void)chooseXiangjiBtnAction:(UIButton *)btn
{
   // NSLog(@"没有相机");
}


#pragma mark ====协议====
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
{
   // NSLog(@"%@",info);
    UIImage *infoImage = info[@"UIImagePickerControllerEditedImage"];
    [self.openXiangceBtn setBackgroundImage:infoImage forState:(UIControlStateNormal)];
    [self dismissViewControllerAnimated:YES completion:^{
        
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
