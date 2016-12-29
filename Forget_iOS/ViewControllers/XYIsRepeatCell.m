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
    NSArray* arrCount;
    NSArray* arrCircle;
    
    NSInteger frquency;
    TimeSetRepeatCircle repeatUnit;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setCustomView];
        
    }
    return self;
}
-(void)setModel:(XYTimeCellModel *)model{
    [super setModel:model];

    arrCount=model.frequenceArr;
    arrCircle=model.reciptCircleUnitArr;
    
    frquency=self.model.setRepeatCount;
    repeatUnit=self.model.setRepeatCircle;
    _repeatLab.text=[NSString stringWithFormat:@"每%zd%@",frquency,arrCircle[repeatUnit]];
    
    [self.myPickerView selectRow:frquency-1 inComponent:0 animated:NO];
    [self.myPickerView selectRow:repeatUnit inComponent:1 animated:NO];
}

-(void)setCustomView{
    _repeatLab=[[UILabel alloc]init];
    _repeatLab.textColor=[UIColor whiteColor];
    _repeatLab.font=SYSTEMFONT(45);
    _repeatLab.textAlignment=NSTextAlignmentCenter;
    
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
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSAttributedString* attStr=nil;
    if (component==0) {
         attStr=[[NSAttributedString alloc]initWithString:arrCount[row] attributes:@{NSForegroundColorAttributeName:THIEM_COLOR_DARKER}];
    }else{
         attStr=[[NSAttributedString alloc]initWithString:arrCircle[row] attributes:@{NSForegroundColorAttributeName:THIEM_COLOR_DARKER}];
    }
    return attStr;
}
//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component==0) {
//        return arrCount[row];
//    }else{
//        return arrCircle[row];
//    }
//
//}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    if (component==0) {
        frquency=[arrCount[row] integerValue];
    }else{
        repeatUnit=row;
    }
    
}

//点击取消或确认
-(void)sureOrNot:(UIButton* )sender{
    [super sureOrNot:sender];
    
    if (sender.tag==1) {//关闭
        
        
    }else{//确认
        NSString* resultStr=[NSString stringWithFormat:@"每%@%@",[NSString stringWithFormat:@"%zd",self.model.setRepeatCount],arrCircle[self.model.setRepeatCircle]];
        _repeatLab.text=resultStr;
        self.model.setRepeatCount=frquency;
        self.model.setRepeatCircle=repeatUnit;
    }
    if (self.sendBlock) {
        self.sendBlock(self.model);
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
