//
//  XYSetTimeView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetTimeView.h"


@interface XYSetTimeView ()<UIPickerViewDelegate,UIPickerViewDataSource>




@end

@implementation XYSetTimeView


- (IBAction)closeClick:(UIButton *)sender {
    self.needSetting=NO;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.pickerView1.delegate=self;
    self.pickerView1.dataSource=self;
    self.pickView2.delegate=self;
    self.pickView2.dataSource=self;
    self.pickView3.delegate=self;
    self.pickView3.dataSource=self;

    
    
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return @"我是PickView  标题";
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 8;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
