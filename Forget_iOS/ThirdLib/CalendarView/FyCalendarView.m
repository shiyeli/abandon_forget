//
//  FyCalendarView.m
//  FYCalendar
//
//  Created by 丰雨 on 16/3/17.
//  Copyright © 2016年 Feng. All rights reserved.
//

#import "FyCalendarView.h"

@interface FyCalendarView ()

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) NSMutableArray *daysArray;
@end

@implementation FyCalendarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDate];
        [self setupNextAndLastMonthView];
    }
    return self;
}

- (void)setupDate {
    self.daysArray = [NSMutableArray arrayWithCapacity:42];
    for (int i = 0; i < 42; i++) {
        UIButton *button = [[UIButton alloc] init];
        [self addSubview:button];
        [_daysArray addObject:button];
        [button addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)setupNextAndLastMonthView {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"calendar_btn_left"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    leftBtn.tag = 1;
    leftBtn.frame = CGRectMake(10, 10, 20, 20);
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"calendar_btn_right"] forState:UIControlStateNormal];
    rightBtn.tag = 2;
    [rightBtn addTarget:self action:@selector(nextAndLastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    rightBtn.frame = CGRectMake(self.frame.size.width - 30, 10, 20, 20);
}

- (void)nextAndLastMonth:(UIButton *)button {
    if (button.tag == 1) {
        if (self.lastMonthBlock) {
            self.lastMonthBlock();
        }
    } else {
        if (self.nextMonthBlock) {
            self.nextMonthBlock();
        }
    }
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    _tempDate=date;
    
    CGFloat itemW     = self.frame.size.width / 8;
    CGFloat itemH     = self.frame.size.width / 8;
    
    // 1.year month
    self.headlabel = [[UILabel alloc] init];
    self.headlabel.text     = [NSString stringWithFormat:@"%li年%li月",(long)[self year:date],(long)[self month:date]];
    NSLog(@"%@", self.headlabel.text);
    self.headlabel.font     = [UIFont systemFontOfSize:14];
    self.headlabel.frame           = CGRectMake(0, 0, self.frame.size.width, itemH);
    self.headlabel.textAlignment   = NSTextAlignmentCenter;
    self.headlabel.textColor = self.headColor;
    [self addSubview: self.headlabel];
    
    UIButton *headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    headBtn.backgroundColor = [UIColor clearColor];
    headBtn.frame = self.headlabel.frame;
    [headBtn addTarget:self action:@selector(chooseMonth:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.headlabel];
    
    // 2.weekday
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    self.weekBg = [[UIView alloc] init];
    //    weekBg.backgroundColor = [UIColor orangeColor];
    self.weekBg.frame = CGRectMake(0, CGRectGetMaxY(self.headlabel.frame), self.frame.size.width, itemH);
    [self addSubview:self.weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i+DISTANCE_TO_EDGE, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = self.weekDaysColor;
        [self.weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        
        int x = (i % 7) * itemW +DISTANCE_TO_EDGE;
        int y = (i / 7) * itemH + CGRectGetMaxY(self.weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x, y, itemW, itemH);
        
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = itemW*0.5;
        dayButton.clipsToBounds=YES;
        [dayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        
        
        
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [self totaldaysInMonth:[self lastMonth:date]];
        NSInteger daysInThisMonth = [self totaldaysInMonth:date];
        NSInteger firstWeekday    = [self firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", (long)day] forState:UIControlStateNormal];
        dayButton.titleLabel.font = [UIFont systemFontOfSize:12];
        
        // this month 标记当前日期
        if ([self month:date] == [self month:[NSDate date]]&&[self year:date]==[self year:[NSDate date]]) {
            
            NSInteger todayIndex = [self day:[NSDate date]] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                //                [self setStyle_BeforeToday:dayButton];
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
//                self.selectBtn=dayButton;
            }
            
        }
        
        // 标记选中日期
        if (self.selectDate) {
            if ([self month:date] == [self month:self.selectDate]&&[self year:date]==[self year:self.selectDate]) {
                
                NSInteger todayIndex = [self day:self.selectDate] + firstWeekday - 1;
                
                if (i < todayIndex && i >= firstWeekday) {
                    //                [self setStyle_BeforeToday:dayButton];
                }else if(i ==  todayIndex){
                    
                    self.selectBtn=dayButton;
                    self.selectBtn.selected=YES;
                    self.selectBtn.backgroundColor=self.cellColor;
                }
                
            }
        }
    }
}

#pragma mark - chooseMonth
- (void)chooseMonth:(UIButton *)button {
    //下期版本
}


#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn
{
    self.selectBtn.selected = NO;
    [self.selectBtn setBackgroundColor:[UIColor clearColor]];
    
    dayBtn.selected = YES;
    self.selectBtn = dayBtn;
    dayBtn.layer.cornerRadius = dayBtn.frame.size.height / 2;
    dayBtn.layer.masksToBounds = YES;
    
    [dayBtn setBackgroundColor:self.dateColor];
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:_tempDate];
    comp.day=day;
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar setTimeZone: [NSTimeZone systemTimeZone]];
    _tempDate = [calendar dateFromComponents:comp];
    
    
    if (self.calendarBlock) {
        self.calendarBlock(_tempDate, comp.day, comp.month, comp.year);
        self.selectDate=_tempDate;
    }
    
}

#pragma mark - date button style

- (void)setStyle_BeyondThisMonth:(UIButton *)btn
{
    btn.enabled = NO;
    if (self.isShowOnlyMonthDays) {
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    } else {
        [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    }
}

//- (void)setStyle_BeforeToday:(UIButton *)btn
//{
//        btn.enabled = NO;
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    for (NSString *str in self.allDaysArr) {
//        if ([str isEqualToString:btn.titleLabel.text]) {
//            UIView *domView = [[UIView alloc] initWithFrame:CGRectMake(btn.frame.size.width / 2 - 3, btn.frame.size.height - 6, 6, 6)];
//            domView.backgroundColor = [UIColor orangeColor];
//            domView.layer.cornerRadius = 3;
//            domView.layer.masksToBounds = YES;
//            [btn addSubview:domView];
//        }
//    }
//    for (NSString *str in self.allDaysArr) {
//        if ([str isEqualToString:btn.titleLabel.text]) {
//            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
//            stateView.layer.cornerRadius = btn.frame.size.height / 2;
//            stateView.layer.masksToBounds = YES;
//            stateView.backgroundColor = [UIColor blueColor];
//            stateView.alpha = 0.5;
//            [btn addSubview:stateView];
//        }
//    }
//}

- (void)setStyle_Today:(UIButton *)btn
{
    btn.layer.cornerRadius = btn.frame.size.height / 2;
    btn.layer.masksToBounds = YES;
    [btn setTitleColor:THIEM_COLOR forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setBackgroundColor:[UIColor whiteColor]];
}

- (void)setStyle_AfterToday:(UIButton *)btn
{;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    for (NSString *str in self.allDaysArr) {
        if ([str isEqualToString:btn.titleLabel.text]) {
            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            stateView.layer.cornerRadius = btn.frame.size.height / 2;
            stateView.layer.masksToBounds = YES;
            stateView.backgroundColor = self.allDaysColor;
            stateView.image = self.allDaysImage;
            stateView.alpha = 0.5;
            [btn addSubview:stateView];
        }
    }
    for (NSString *str in self.partDaysArr) {
        if ([str isEqualToString:btn.titleLabel.text]) {
            UIImageView *stateView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height)];
            stateView.layer.cornerRadius = btn.frame.size.height / 2;
            stateView.layer.masksToBounds = YES;
            stateView.backgroundColor = self.partDaysColor;
            stateView.image = self.partDaysImage;
            stateView.alpha = 0.5;
            [btn addSubview:stateView];
        }
    }
}

#pragma mark - Lazy loading
- (NSArray *)allDaysArr {
    if (!_allDaysArr) {
        _allDaysArr = [NSArray array];
    }
    return _allDaysArr;
}

- (NSArray *)partDaysArr {
    if (!_partDaysArr) {
        _partDaysArr = [NSArray array];
    }
    return _partDaysArr;
}

- (UIColor *)headColor {
    if (!_headColor) {
        _headColor = BLACK_FONT_COLOR;
    }
    return _headColor;
}

- (UIColor *)dateColor {
    if (!_dateColor) {
        _dateColor = _cellColor;
    }
    return _dateColor;
}

- (UIColor *)allDaysColor {
    if (!_allDaysColor) {
        _allDaysColor = [UIColor blueColor];
    }
    return _allDaysColor;
}

- (UIColor *)partDaysColor {
    if (!_partDaysColor) {
        _partDaysColor = [UIColor cyanColor];
    }
    return _partDaysColor;
}

- (UIColor *)weekDaysColor {
    if (!_weekDaysColor) {
        _weekDaysColor = [UIColor lightGrayColor];
    }
    return _weekDaysColor;
}

//一个月第一个周末
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *component = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [component setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:component];
    NSUInteger firstWeekDay = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekDay - 1;
}

//总天数
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

#pragma mark - month +/-

- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}


#pragma mark - date get: day-month-year

- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
