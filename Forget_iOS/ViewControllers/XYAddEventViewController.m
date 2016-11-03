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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activeMarkViewCT;

@property (weak, nonatomic) IBOutlet UIButton *setTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *setLocationBtn;




@end

@implementation XYAddEventViewController

- (IBAction)accomplish:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)timeLocationClick:(UIButton *)sender {
    
    self.activeMarkViewCT.constant=Main_Screen_Width*0.5*(sender.tag -1);
    if ([sender isEqual:self.setTimeBtn]) {
        self.setLocationBtn.selected=NO;
    }else{
        self.setTimeBtn.selected=NO;
    }
    sender.selected=YES;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserInterface];
    
   
}
-(void)setUserInterface{
    [self.setTimeBtn setImage:[UIImage imageNamed:@"set_time_select"] forState:UIControlStateSelected];
    [self.setTimeBtn setImage:[UIImage imageNamed:@"set_time_unselect"] forState:UIControlStateNormal];
    [self.setLocationBtn setImage:[UIImage imageNamed:@"set_location_select"] forState:UIControlStateSelected];
    [self.setLocationBtn setImage:[UIImage imageNamed:@"set_location_unselect"] forState:UIControlStateNormal];
    self.setTimeBtn.selected=YES;
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
