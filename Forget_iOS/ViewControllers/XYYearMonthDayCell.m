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
}
-(void)setCustomView{
    _yearLab=[[UILabel alloc]init];
    _yearLab.textColor=[UIColor whiteColor];
    _yearLab.text=@"2016";
    _yearLab.font=SYSTEMFONT(15);
    [self.titleView addSubview:_yearLab];
    [_yearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE*0.7);
        make.leading.equalTo(self.titleView).with.offset(DISTANCE_TO_EDGE);
    }];

    _monthDayLab=[[UILabel alloc]init];
    _monthDayLab.textColor=[UIColor whiteColor];
    _monthDayLab.text=@"十月四日,星期五";
    _monthDayLab.font=SYSTEMFONT(22);
    [self.titleView addSubview:_monthDayLab];
    [_monthDayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleView).with.offset(-DISTANCE_TO_EDGE*0.7);
        make.leading.equalTo(_yearLab);
    }];
    
    [self setupCalendarView];

}


- (void)setupCalendarView {
    
 
    self.calendarView = [[FyCalendarView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2)];
    [self.centerView addSubview:self.calendarView];
    
    //日期状态
//    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"8", @"9", @"17",  @"30", nil];
//    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"12",@"15", @"19",nil];
    //    self.calendarView.isShowOnlyMonthDays = NO;
    self.calendarView.date = [NSDate date];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
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
    [self.centerView addSubview:self.calendarView];
   
    
//    self.calendarView.allDaysArr = [NSArray arrayWithObjects:  @"17",  @"21", @"25",  @"30", nil];
//    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"19",nil];
    tempDate = [self.calendarView nextMonth:tempDate];
    [self.calendarView createCalendarViewWith:tempDate];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
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
    [self.centerView addSubview:self.calendarView];
    
//    self.calendarView.allDaysArr = [NSArray arrayWithObjects: @"5", @"6", @"8", @"9", @"11", @"16", @"17", @"21", @"25",  @"30", nil];
//    self.calendarView.partDaysArr = [NSArray arrayWithObjects:@"1", @"2", @"26", @"29", @"12",@"15", @"18", @"19",nil];
    tempDate = [self.calendarView lastMonth:tempDate];
    [self.calendarView createCalendarViewWith:tempDate];
    self.calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        NSLog(@"%li-%li-%li", (long)year,(long)month,(long)day);
    };
    WS(weakSelf)
    self.calendarView.lastMonthBlock = ^(){
        [weakSelf setupLastMonth];
    };
    self.calendarView.nextMonthBlock = ^(){
        [weakSelf setupNextMonth];
    };

}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
