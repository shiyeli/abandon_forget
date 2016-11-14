//
//  XYIsRepeatCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYIsRepeatCell.h"

@implementation XYIsRepeatCell
{
    NSMutableArray* arrCount;
    NSMutableArray* arrCircle;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setDataArray];
        [self setCustomView];
    }
    return self;
}
-(void)setDataArray{
    
    arrCount=[NSMutableArray array];
    for (int i=0; i<5; i++) {
        NSString* temStr=[NSString stringWithFormat:@"%d",i+1];
        [arrCount addObject:temStr];
    }
    arrCircle=[NSMutableArray arrayWithArray:TimeSetRepeatCircleArr];
    
    
    
}


-(void)setCustomView{
    _repeatLab=[[UILabel alloc]init];
    _repeatLab.textColor=[UIColor whiteColor];
    _repeatLab.font=SYSTEMFONT(45);
    _repeatLab.textAlignment=NSTextAlignmentCenter;
    _repeatLab.text=[NSString stringWithFormat:@"每%@%@",arrCount[0],arrCircle[0]];
    [self.titleView addSubview:_repeatLab];
    [_repeatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.titleView);
    }];
    
    
    _myPickerView=[[UIPickerView alloc]init];
    _myPickerView.delegate=self;
    _myPickerView.dataSource=self;
    [self.centerView addSubview:_myPickerView];
    [_myPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerView);
        make.leading.equalTo(self.centerView);
        make.trailing.equalTo(self.centerView);
    }];
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return 5;
    }else{
        return 3;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return arrCount[row];
    }else{
        return arrCircle[row];
    }

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if (component==0) {
        self.model.setRepeatCount=arrCount[row];
    }else{
        self.model.setRepeatCircle=row;
    }
    
}

//点击取消或确认
-(void)sureOrNot:(UIButton* )sender{
    [super sureOrNot:sender];
    
    if (sender.tag==1) {//关闭
        
        
    }else{//确认
        NSString* resultStr=[NSString stringWithFormat:@"每%@%@",self.model.setRepeatCount,arrCircle[self.model.setRepeatCircle]];
        _repeatLab.text=resultStr;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
