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
#import "XYAddAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "XYAnimationViewModel.h"

@interface XYAddEventViewController ()<XYAddAddressViewControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *activeMarkViewCT;

@property (weak, nonatomic) IBOutlet UIButton *setTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *setLocationBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@property(nonatomic,strong)XYSetTimeView* timeView;

@property(nonatomic,strong)XYSetLoctionView* locationView;


@end

@implementation XYAddEventViewController


- (IBAction)accomplish:(id)sender {
    //此处判断存储数据
    if (!self.model.haveSetLocation&&!self.model.haveSetTime) {
        [XYTool showPromptView:@"时间或地点请至少设置一项" holdView:nil];
        return;
    }
    
    if (self.model.haveSetLocation) {
        //是个人地点
        
        if (self.model.isPersonalLocation) {
            if (self.model.tip==nil) {
                [XYTool showPromptView:@"请设置tip" holdView:nil];
                 return;
            }
        }else{
            if (self.model.locationClassifition.length==0) {
                [XYTool showPromptView:@"请设置一类地点" holdView:nil];
                return;
            }
        }
    }
 
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    self.view.backgroundColor=THIEM_COLOR;
    
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
    
    //配置视图默认显示数据
    //提醒时间
    self.model.haveSetTime=YES;
    self.model.notifyTime=[NSDate date];
    //重复
    self.model.haveSetRepeat=YES;
    self.model.frequency=1;
    self.model.repeatUnit=TimeSetRepeatDay;
    //关闭提醒时间
    
    self.model.haveSetClosingDate=YES;
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
    self.model.closingDate=newDate;
    
    //提醒地点
    self.model.haveSetLocation=YES;
    self.model.isArrvialNotify=YES;
    
    
    self.timeView.model=self.model;
    self.locationView.model=self.model;
    
    WS(weakSelf)
    self.timeView.sendBlock=^(id sender){
    
    
    
    };
    
    self.locationView.sendBlock=^(id sender){
        
        if ([sender respondsToSelector:@selector(tag)]) {
            if ([sender tag]==3) {
                //搜索
                [weakSelf performSegueWithIdentifier:@"XYAddAddressViewController" sender:nil];
            }else if ([sender tag]==1){
                //提醒地点开关
                UISwitch* tempSwitch=(UISwitch*)sender;
                weakSelf.model.haveSetLocation=tempSwitch.isOn;
            }else if ([sender tag]==4){
                //到达地点
                weakSelf.model.isArrvialNotify=YES;
                
            }else if ([sender tag]==5){
                //离开地点
                weakSelf.model.isArrvialNotify=NO;
            }
        }
        
        if ([sender isKindOfClass:[XYAnimationViewModel class]]) {
            XYAnimationViewModel* model=(XYAnimationViewModel *)sender;
            if (model.isNameLeft) {
                weakSelf.model.isPersonalLocation=NO;
                weakSelf.model.locationClassifition=model.name;
            }else{
                weakSelf.model.isPersonalLocation=YES;
                weakSelf.model.tip=model.tip;
            }
            
        }
        
        if ([sender isKindOfClass:[AMapTip class]]) {
            weakSelf.model.tip=sender;
            weakSelf.model.isPersonalLocation=YES;
        }
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - XYAddAddressViewControllerDelegate
-(void)getNewSearchAddress:(XYAddAddressViewController*)currentCtl content:(AMapTip*)tip{
    [self.locationView addNewAddress:tip];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[XYAddAddressViewController class]]) {
        XYAddAddressViewController* addAddressCtl=(XYAddAddressViewController*)segue.destinationViewController;
        addAddressCtl.delegate=self;
    }
}


@end
