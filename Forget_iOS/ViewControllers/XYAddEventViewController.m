//
//  XYAddEventViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAddEventViewController.h"

@interface XYAddEventViewController ()

@end

@implementation XYAddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickOnView:(UIButton*)sender {
    switch (sender.tag) {
        case 1:{
            //提醒场合
            //[self performSegueWithIdentifier:@"XYAddAddressViewController" sender:nil];
        }
            break;
            
        case 2:{
            //提醒时间
            //[self performSegueWithIdentifier:@"XYWillNotifyViewController" sender:nil];
            
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
