//
//  XYHourMinuteCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYHourMinuteCell.h"

@implementation XYHourMinuteCell
{
    UIButton* hourBtn;
    UIButton* minuteBtn;
    UIButton* amBtn;
    UIButton* pmBtn;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self setCustomView];
        [self setHourMInWithDate:[NSDate date]];
        
    }
    return self;
}
-(void)titleViewClick:(UIButton*)sender{
    sender.selected=YES;
    
    switch (sender.tag) {
        case 1:
        {
            minuteBtn.selected=NO;
            [self setClockViewHour:YES];
            
        }
            break;
        case 2:
        {
            hourBtn.selected=NO;
            [self setClockViewHour:NO];
        }
            break;
        case 3:
        {
            pmBtn.selected=NO;
        }
            break;
        case 4:
        {
            amBtn.selected=NO;
        }
            break;
            
        default:
            break;
    }


}
-(void)setCustomView{
    
    
    UIColor* normalColor=RGBACOLOR(255, 255, 255, 0.7);
    UIColor* selectColor=[UIColor whiteColor];
    UIFont* font=SYSTEMFONT(45);
    UIFont* font_smaller=SYSTEMFONT(20);
    
    UILabel* centerLab=[[UILabel alloc]init];
    centerLab.text=@":";
    centerLab.textColor=selectColor;
    centerLab.font=font;
    [self.titleView addSubview:centerLab];
    [centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.centerX.equalTo(self.titleView).with.offset(-DISTANCE_TO_EDGE*1.5);
    }];
    
    
    
    hourBtn=[[UIButton alloc]init];
    [hourBtn setTitleColor:selectColor forState:UIControlStateSelected];
    [hourBtn setTitleColor:normalColor forState:UIControlStateNormal];
    hourBtn.titleLabel.font=font;
    hourBtn.selected=YES;
    hourBtn.tag=1;
    [hourBtn addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:hourBtn];
    [hourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.leading.equalTo(centerLab.mas_leading).with.offset(-55);
    }];
    
    
    minuteBtn=[[UIButton alloc]init];
    [minuteBtn setTitleColor:selectColor forState:UIControlStateSelected];
    [minuteBtn setTitleColor:normalColor forState:UIControlStateNormal];
    minuteBtn.titleLabel.font=font;
    minuteBtn.tag=2;
    [minuteBtn addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:minuteBtn];
    [minuteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.leading.equalTo(centerLab.mas_trailing);
    }];
    
    
    amBtn=[[UIButton alloc]init];
    [amBtn setTitleColor:selectColor forState:UIControlStateSelected];
    [amBtn setTitleColor:normalColor forState:UIControlStateNormal];
    amBtn.titleLabel.font=font_smaller;
    amBtn.tag=3;
    amBtn.selected=YES;
    [amBtn setTitle:@"AM" forState:UIControlStateNormal];
    [amBtn addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:amBtn];
    [amBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(centerLab);
        make.leading.equalTo(centerLab.mas_trailing).with.offset(65);
    }];
    
    pmBtn=[[UIButton alloc]init];
    [pmBtn setTitleColor:selectColor forState:UIControlStateSelected];
    [pmBtn setTitleColor:normalColor forState:UIControlStateNormal];
    pmBtn.titleLabel.font=font_smaller;
    pmBtn.tag=4;
    [pmBtn setTitle:@"PM" forState:UIControlStateNormal];
    [pmBtn addTarget:self action:@selector(titleViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.titleView addSubview:pmBtn];
    [pmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(centerLab);
        make.leading.equalTo(amBtn);
    }];
    
    _clockView=[[ALDClock alloc]initWithFrame:CGRectMake(DISTANCE_TO_EDGE, DISTANCE_TO_EDGE, Main_Screen_Width-DISTANCE_TO_EDGE*4, Main_Screen_Width-DISTANCE_TO_EDGE*4)];
    [self.centerView addSubview:_clockView];
    [self applyClockCustomisations];
    self.clockView.isHour=YES;
    
    
}

-(void)setClockViewHour:(BOOL)isHour{
    _clockView.isHour=isHour;
    
    
    [self setHourMInWithDate:[NSDate date]];

}


-(void)setHourMInWithDate:(NSDate*)date{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:date];
    [self setHour:comp.hour];
    [self setMinute:comp.minute];
    
}

-(void)setHour:(NSInteger)hour{
    [hourBtn setTitle:[NSString stringWithFormat:@"%02d",hour] forState:UIControlStateNormal];
    
}
-(void)setMinute:(NSInteger)minute{
    [minuteBtn setTitle:[NSString stringWithFormat:@"%02d",minute] forState:UIControlStateNormal];
}

- (void)applyClockCustomisations
{
    // Change the background color of the clock (note that this is the color
    // of the clock face)
    self.clockView.backgroundColor =[XYTool stringToColor:@"#F5F5F5"];
    
    // Add a title and subtitle to the clock face
    self.clockView.title = @"";
    self.clockView.subtitle = @"";
    
    // When the time changes, call the the clockDidChangeTime: method.
    [self.clockView addTarget:self action:@selector(clockDidChangeTime:) forControlEvents:UIControlEventValueChanged];
    
    // When the user begins/ends manually changing the time, call these methods.
    [self.clockView addTarget:self action:@selector(clockDidBeginDragging:) forControlEvents:UIControlEventTouchDragEnter];
    [self.clockView addTarget:self action:@selector(clockDidEndDragging:) forControlEvents:UIControlEventTouchDragExit];
    
    // Set the initial time
    [self.clockView setHour:13 minute:51 animated:NO];
    
    // Change the clock's border color and width
    self.clockView.borderColor = THIEM_COLOR;
    self.clockView.borderWidth = 0.0f;
}

#pragma mark - Clock Callback Methods

- (void)clockDidChangeTime:(ALDClock *)clock
{
    NSLog(@"The time is: %02d:%02d", clock.hour, clock.minute);
    if (clock.isHour) {
        [self setHour:clock.minute/5];
    }else{
        [self setMinute:clock.minute];
    }
    
}

- (void)clockDidBeginDragging:(ALDClock *)clock
{
    clock.borderColor = [UIColor colorWithRed:0.78 green:0.22 blue:0.22 alpha:1.0];
}

- (void)clockDidEndDragging:(ALDClock *)clock
{
    clock.borderColor = [UIColor colorWithRed:0.22 green:0.78 blue:0.22 alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
