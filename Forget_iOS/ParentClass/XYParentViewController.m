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
    
    self.navigationController.navigationBar.barTintColor=THIEM_COLOR;
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=THIEM_COLOR;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
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
