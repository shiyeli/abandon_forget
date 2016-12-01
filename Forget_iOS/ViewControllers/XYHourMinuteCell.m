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
    
    BOOL _isAM;
    NSInteger _hour;
    NSInteger _minute;
    
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
    
    [self setHourMInWithDate:model.setDate];
   
}


//-(void)changeHoutMintuteAnimation{
//    CATransition* transtiton=[CATransition animation];
//    transtiton.duration=0.3;
//    transtiton.type=@"kCATransitionFade";
//    [self.centerView.layer addAnimation:transtiton forKey:nil];
//
//}

-(void)titleViewClick:(UIButton*)sender{
    
    if (self.model.isSpreadOut==NO) {
        [self spreadOutCell:nil];
        return;
    }
    
    sender.selected=YES;
    
    switch (sender.tag) {
        case 1:
        {
            minuteBtn.selected=NO;
            self.clockView.isChange=YES;
            self.clockView.isHour=YES;
            [self.clockView setMinute:[hourBtn.titleLabel.text integerValue]*5];
            
        }
            break;
        case 2:
        {
            hourBtn.selected=NO;
            self.clockView.isChange=YES;
            self.clockView.isHour=NO;
            [self.clockView setMinute:[minuteBtn.titleLabel.text integerValue]];
            
        }
            break;
        case 3:
        {
            pmBtn.selected=NO;
            _isAM=YES;
        }
            break;
        case 4:
        {
            amBtn.selected=NO;
            _isAM=NO;
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
    minuteBtn.selected=YES;
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
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:[NSDate date]];
    [self.clockView setMinute:comp.hour*5];
}


-(void)setHourMInWithDate:(NSDate*)date{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:date];
    
    if (!self.model.isSpreadOut) {
        if (comp.hour>12) {
            comp.hour-=12;
            pmBtn.selected=YES;
            amBtn.selected=NO;
            amBtn.hidden=YES;
            pmBtn.hidden=NO;
            _isAM=NO;
            
            
        }else{
            pmBtn.selected=NO;
            amBtn.selected=YES;
            pmBtn.hidden=YES;
            amBtn.hidden=NO;
            _isAM=YES;
        }
    }else{//展开视图
        if (comp.hour>12) {
            comp.hour-=12;
            pmBtn.selected=YES;
            amBtn.selected=NO;
            amBtn.hidden=NO;
            pmBtn.hidden=NO;
            _isAM=NO;
            
            
        }else{
            pmBtn.selected=NO;
            amBtn.selected=YES;
            pmBtn.hidden=NO;
            amBtn.hidden=NO;
            _isAM=YES;
        }
    
    }
    
    _hour=comp.hour;
    _minute=comp.minute;
    
    self.model.isAM=_isAM;
    self.model.hour=_hour;
    self.model.minitue=_minute;
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
    if (self.clockView.isChange) {
        self.clockView.isChange=NO;
        return;
    }
    NSLog(@"The time is: %02d:%02d", clock.hour, clock.minute);
    if (clock.isHour) {
        _hour=clock.minute/5;
        [self setHour:_hour];
        
    }else{
        _minute=clock.minute;
        [self setMinute:_minute];
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

-(void)spreadOutCell:(UIButton *)sender{
    [super spreadOutCell:sender];
    hourBtn.selected=YES;
    minuteBtn.selected=NO;
    [self titleViewClick:hourBtn];
    
    amBtn.hidden=NO;
    pmBtn.hidden=NO;
}

-(void)sureOrNot:(UIButton *)sender{
    [super sureOrNot:sender];
    
    if (amBtn.selected==YES) {
        pmBtn.hidden=YES;
        amBtn.hidden=NO;
    }else{
        amBtn.hidden=YES;
        pmBtn.hidden=NO;
    }
    hourBtn.selected=YES;
    minuteBtn.selected=YES;
    
    if (sender.tag==1) {//关闭
    }else{//确认
        self.model.isAM=_isAM;
        self.model.hour=_hour;
        self.model.minitue=_minute;
    }
    
    [self setMinute:self.model.minitue];
    [self setHour:self.model.hour];
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
