//
//  XYParentViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentViewController.h"

@interface XYParentViewController ()<UIGestureRecognizerDelegate>

@end

@implementation XYParentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]init];
    tap.delegate=self;
    [self.view addGestureRecognizer:tap];
    
    //设置标题/导航栏按钮颜色/导航栏/视图背景色
    self.navigationController.navigationBar.barTintColor=THIEM_COLOR;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=THIEM_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    //去除返回按钮文字
    UIButton* backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"cancel_item"] forState:UIControlStateNormal];
    UIBarButtonItem* backItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    
    //UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    //UIImage * backImg=[[UIImage imageNamed:@"cancel_item"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //[backBtn setBackButtonBackgroundImage:backImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    self.navigationItem.leftBarButtonItem = backItem;
}
-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
  
    if (![NSStringFromClass([touch.view class]) isEqualToString:@"HWTextView"]) {
        [self.view endEditing:YES];
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
