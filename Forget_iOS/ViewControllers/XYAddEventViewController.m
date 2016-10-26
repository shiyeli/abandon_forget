//
//  XYAddEventViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAddEventViewController.h"
#import "HWTextView.h"
@interface XYAddEventViewController ()

@property (weak, nonatomic) IBOutlet HWTextView *notifyContent;




@end

@implementation XYAddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.notifyContent.placeholder=@"请输入提醒时间备注信息";
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
