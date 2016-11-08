//
//  XYMainViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYMainViewController.h"
#import "SWRevealViewController.h"
@interface XYMainViewController ()

@end

@implementation XYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settingsOfSlide];
    
    
}

-(void)settingsOfSlide{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"slider_view_btn"]style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickOnView:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //添加提醒事件
            UINavigationController* AddEventNavi=[[UIStoryboard storyboardWithName:@"AddEvent" bundle:nil] instantiateInitialViewController];
            [self presentViewController:AddEventNavi animated:YES completion:^{
                
            }];
            
            
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
