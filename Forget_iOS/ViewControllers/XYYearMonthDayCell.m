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
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCustomView];
        [self setData];
    }
    return self;
}
-(void)setData{
    tempDate=[NSDate date];
    [self setYearMonthDay:tempDate];
}
-(void)setCustomView{
    _yearLab=[[UILabel alloc]init];
    _yearLab.textColor=[UIColor whiteColor];
    
    _yearLab.font=SYSTEMFONT(15);
    [self.titleView addSubview:_yearLab];
    [_yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE*0.7);
        make.leading.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE);
    }];

    _monthDayLab=[[UILabel alloc]init];
    _monthDayLab.textColor=[UIColor whiteColor];
    
    _monthDayLab.font=SYSTEMFONT(22);
    [self.titleView addSubview:_monthDayLab];
    [_monthDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleView).with.offset(-DISTANCE_TO_EDGE*0.7);
        make.leading.equalTo(_yearLab);
    }];
    
    [self setupCalendarView];

    
    
}

-(void)setCellColor:(UIColor *)cellColor{
    [super setCellColor:cellColor];
    if (self.calendarView) {
        self.calendarView.cellColor=self.cellColor;
    }
}

- (void)setupCalendarView {
    
 
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
    
    [self.centerView addSubview:self.calendarView];
    

    self.calendarView.date = [NSDate date];
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

-(void)sureOrNot:(UIButton *)sender{
    [super sureOrNot:sender];
    
    if (sender.tag==1) {//关闭
        self.model.setDate=[NSDate date];
        
    }else{//确认
        [self setYearMonthDay:self.calendarView.tempDate];
    }

}

-(void)setYearMonthDay:(NSDate*)date{
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    //更新界面
    
    _yearLab.text=[NSString stringWithFormat:@"%zd",comp.year];
    _monthDayLab.text=[NSString stringWithFormat:@"%zd月%zd日,%@",comp.month,comp.day,[XYTool getWeekdayStringFromDate:date]];
    
    //存储时间
    
    self.model.setDate=date;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
