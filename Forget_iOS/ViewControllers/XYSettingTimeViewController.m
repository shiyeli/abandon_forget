//
//  XYSettingTimeViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSettingTimeViewController.h"
#import "XYNotifyPropertyChangeView.h"
@interface XYSettingTimeViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;

@property (weak, nonatomic) IBOutlet XYNotifyPropertyChangeView *notifySettingView;

@end

@implementation XYSettingTimeViewController

- (IBAction)accomplish:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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