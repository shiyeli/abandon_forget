//
//  XYMainViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYMainViewController.h"

@interface XYMainViewController ()

@end

@implementation XYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickOnView:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //添加常用地址
            [self performSegueWithIdentifier:@"XYAddAddressViewController" sender:nil];
        }
            break;
         
        case 2:{
            //设置
            
        }
            break;
        case 3:{
            //提醒事项
            [self performSegueWithIdentifier:@"XYWillNotifyViewController" sender:nil];
        }
            break;

        default:
            break;
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