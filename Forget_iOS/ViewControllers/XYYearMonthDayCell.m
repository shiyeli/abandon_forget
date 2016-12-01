//
//  XYYearMonthDayCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYYearMonthDayCell.h"

@implementation XYYearMonthDayCell
{
    NSDate * tempDate;
    NSMutableArray* yearArr;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCustomView];
        
    }
    return self;
}
-(UIPickerView*)yearPicker{
    if (!_yearPicker) {
        _yearPicker=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
        _yearPicker.delegate=self;
        _yearPicker.dataSource=self;
        [self.centerView addSubview:_yearPicker];
        _yearPicker.hidden=YES;
        
    }
    return _yearPicker;
}
-(void)setModel:(XYTimeCellModel *)model{
    [super setModel:model];
    [self setData];
}
-(void)setData{
    tempDate=self.model.setDate;
    [self setYearMonthDay:tempDate];
    
    
    //年份列表
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    yearArr=[NSMutableArray array];
    for (NSInteger i=comp.year; i<comp.year+50; i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%zd",i]];
    }
    
}
-(void)setCustomView{
    UIColor* normalColor=RGBACOLOR(255, 255, 255, 0.7);
    UIColor* selectColor=[UIColor whiteColor];
    
    _yearLab=[[UIButton alloc]init];
    [_yearLab setTitleColor:selectColor forState:UIControlStateSelected];
    [_yearLab setTitleColor:normalColor forState:UIControlStateNormal];
    _yearLab.selected=YES;
    [_yearLab.titleLabel setFont:SYSTEMFONT(15)];
    [_yearLab addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    _yearLab.tag=kTag+1;
    [self.titleView addSubview:_yearLab];
    [_yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE*0.3);
        make.leading.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE);
    }];

    _monthDayLab=[[UIButton alloc]init];
    [_monthDayLab setTitleColor:selectColor forState:UIControlStateSelected];
    [_monthDayLab setTitleColor:normalColor forState:UIControlStateNormal];
    _monthDayLab.selected=YES;
    [_monthDayLab.titleLabel setFont:SYSTEMFONT(22)];
    [_monthDayLab addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:_monthDayLab];
    [_monthDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleView).with.offset(-DISTANCE_TO_EDGE*0.3);
        make.leading.equalTo(_yearLab);
    }];
    
    [self setupCalendarView:[NSDate date]];
    
    
    
}
-(void)titleViewClick:(UIButton*)sender{
    
    if (!self.model.isSpreadOut) {
        return;
    }
    
    sender.selected=YES;
    if (sender.tag==kTag+1) {//点击年份
        _monthDayLab.selected=NO;
        self.yearPicker.hidden=NO;
        self.calendarView.hidden=YES;
        [self.yearPicker reloadAllComponents];
        

    }else{//点击日历
        _yearLab.selected=NO;
        self.calendarView.hidden=NO;
        self.yearPicker.hidden=YES;
        
        if (self.calendarView) {
            [self.calendarView removeFromSuperview];
        }
        [self setupCalendarView:tempDate];
    }
    
}
-(void)setCellColor:(UIColor *)cellColor{
    [super setCellColor:cellColor];
    if (self.calendarView) {
        self.calendarView.cellColor=self.cellColor;
    }
}

- (void)setupCalendarView:(NSDate*)date {
    
 
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
    
    [self.centerView addSubview:self.calendarView];
    

    self.calendarView.date = date;
    self.calendarView.cellColor=self.cellColor;
    WS(weakSelf)
    self.calendarView.calendarBlock =  ^(NSDate* selectDate,NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%@ %li-%li-%li",selectDate, (long)year,(long)month,(long)day);
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
}

- (void)setupNextMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
    self.calendarView.cellColor=self.cellColor;
    [self.centerView addSubview:self.calendarView];
    

    tempDate = [self.calendarView nextMonth:tempDate];
    [self.calendarView createCalendarViewWith:tempDate];
    WS(weakSelf)
    self.calendarView.calendarBlock =  ^(NSDate* selectDate,NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%@ %li-%li-%li",selectDate, (long)year,(long)month,(long)day);
        
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };

}

- (void)setupLastMonth {
    [self.calendarView removeFromSuperview];
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
    self.calendarView.cellColor=self.cellColor;
    [self.centerView addSubview:self.calendarView];

    tempDate = [self.calendarView lastMonth:tempDate];
    [self.calendarView createCalendarViewWith:tempDate];
    WS(weakSelf)
    self.calendarView.calendarBlock =  ^(NSDate* selectDate,NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%@ %li-%li-%li",selectDate, (long)year,(long)month,(long)day);
        
    };
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };

}
-(void)spreadOutCell:(UIButton *)sender{
    [super spreadOutCell:sender];
    _yearLab.selected=NO;
    _monthDayLab.selected=YES;
    
    _yearPicker.hidden=YES;
    _calendarView.hidden=NO;
}

-(void)sureOrNot:(UIButton *)sender{
    
    _yearLab.selected=YES;
    _monthDayLab.selected=YES;
    
    if (sender.tag==1) {//关闭
        //self.model.setDate=[NSDate date];
        
    }else{//确认
        if (self.calendarView.selectDate==nil) {
            [XYTool showPromptView:@"请选择日期" holdView:self.centerView];
            return;
        }
        [self setYearMonthDay:self.calendarView.selectDate];
        
        //存储时间
        self.model.setDate=self.calendarView.selectDate;
        if (self.sendBlock) {
            self.sendBlock(self.model);
        }
    }
    
    [super sureOrNot:sender];
}

-(void)setYearMonthDay:(NSDate*)date{
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //更新界面
    
    [_yearLab setTitle:[NSString stringWithFormat:@"%zd",comp.year] forState:UIControlStateNormal];
    [_monthDayLab setTitle:[NSString stringWithFormat:@"%zd月%zd日,%@",comp.month,comp.day,[XYTool getWeekdayStringFromDate:date]] forState:UIControlStateNormal];
    
    
}

#pragma mark - UIPickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return yearArr.count;
}
-(NSAttributedString*)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSAttributedString* attStr=[[NSAttributedString alloc]initWithString:yearArr[row] attributes:@{NSForegroundColorAttributeName:THIEM_COLOR_DARKER}];
    
    return attStr;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_yearLab setTitle:yearArr[row] forState:UIControlStateNormal];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:tempDate];
    comp.year=[_yearLab.titleLabel.text integerValue];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone: [NSTimeZone systemTimeZone]];
    tempDate = [calendar dateFromComponents:comp];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
