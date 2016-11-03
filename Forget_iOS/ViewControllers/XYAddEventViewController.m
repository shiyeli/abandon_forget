//
//  XYAddEventViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAddEventViewController.h"
#import "XYSetTimeView.h"
#import "XYSetLoctionView.h"
@interface XYAddEventViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activeMarkViewCT;

@property (weak, nonatomic) IBOutlet UIButton *setTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *setLocationBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property(nonatomic,strong)XYSetTimeView* timeView;

@property(nonatomic,strong)XYSetLoctionView* locationView;


@end

@implementation XYAddEventViewController


- (IBAction)accomplish:(id)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)timeLocationClick:(UIButton *)sender {
    
    //调整按钮
    self.activeMarkViewCT.constant=Main_Screen_Width*0.5*(sender.tag -1);
    if ([sender isEqual:self.setTimeBtn]) {
        self.setLocationBtn.selected=NO;
    }else{
        self.setTimeBtn.selected=NO;
    }
    sender.selected=YES;
    
    //调整对应视图
    [self.myScrollView setContentOffset:CGPointMake(self.activeMarkViewCT.constant*2, 0) animated:YES];
    
    
}






- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUserInterface];
    
   
}
-(void)setUserInterface{
    //按钮设置
    [self.setTimeBtn setImage:[UIImage imageNamed:@"set_time_select"] forState:UIControlStateSelected];
    [self.setTimeBtn setImage:[UIImage imageNamed:@"set_time_unselect"] forState:UIControlStateNormal];
    [self.setLocationBtn setImage:[UIImage imageNamed:@"set_location_select"] forState:UIControlStateSelected];
    [self.setLocationBtn setImage:[UIImage imageNamed:@"set_location_unselect"] forState:UIControlStateNormal];
    self.setTimeBtn.selected=YES;
    
    
    //视图加载
    self.locationView=[[[NSBundle mainBundle]loadNibNamed:@"XYSetLoctionView" owner:nil options:nil] lastObject];
    self.timeView=[[[NSBundle mainBundle]loadNibNamed:@"XYSetTimeView" owner:nil options:nil] lastObject];
    [self.view layoutIfNeeded];
    CGFloat scrollViewH=self.myScrollView.frame.size.height;
    [self.timeView setFrame:CGRectMake(0, 0, Main_Screen_Width, scrollViewH)];
    [self.locationView setFrame:CGRectMake(Main_Screen_Width, 0, Main_Screen_Width, scrollViewH)];
    [self.myScrollView addSubview:self.timeView];
    [self.myScrollView addSubview:self.locationView];
    
    [self.myScrollView setContentSize:CGSizeMake(Main_Screen_Width*2.0, 1)];
    self.myScrollView.scrollEnabled=NO;
    self.myScrollView.showsHorizontalScrollIndicator=NO;
    
    
    
    
    
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
