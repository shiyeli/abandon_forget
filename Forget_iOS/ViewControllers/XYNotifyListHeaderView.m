//
//  XYNotifyListHeaderView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/24.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYNotifyListHeaderView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "AMapTipAnnotation.h"

@interface XYNotifyListHeaderView ()

@property(nonatomic,strong)UIView* timeHold;
@property(nonatomic,strong)UILabel* year;
@property(nonatomic,strong)UILabel* month_day;
@property(nonatomic,strong)UILabel* hour;


@property(nonatomic,strong)UIView* locationHold;
@property(nonatomic,strong)MAMapView* myMap;



@property(nonatomic,strong)UIView* imgHold;
@property(nonatomic,strong)UIImageView* imgView;




@end

@implementation XYNotifyListHeaderView

-(void)setModel:(XYNotifyModel *)model{
    _model=model;
    
    if (_model.haveSetTime) {
        [self bringSubviewToFront:self.timeHold];
        
        
        NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |kCFCalendarUnitHour|kCFCalendarUnitMinute) fromDate:_model.notifyTime];
        
        self.year.text=[NSString stringWithFormat:@"%zd",comp.year];
        
        NSString* monthStr=[XYTool translationArabicNum:comp.month];
        NSString* dayStr=[XYTool translationArabicNum:comp.day];
        NSString* weekdayStr=[XYTool getWeekdayStringFromDate:_model.notifyTime];
        self.month_day.text=[NSString stringWithFormat:@"%@月%@日,%@",monthStr,dayStr,weekdayStr];
        
        self.hour.attributedText=[self setAttriHour:comp.hour minute:comp.minute];
        
        
    }else if (_model.haveSetLocation&&_model.isPersonalLocation){
        [self bringSubviewToFront:self.locationHold];
        
        [self.myMap removeAnnotations:self.myMap.annotations];
        
        AMapTipAnnotation* tipAnno = [[AMapTipAnnotation alloc] initWithMapTip:_model.tip];
        [self.myMap addAnnotation:tipAnno];
        [self.myMap setCenterCoordinate:tipAnno.coordinate];
        _myMap.zoomLevel=15;

    }else{
         [self bringSubviewToFront:self.imgHold];
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.notifyImgUrl]];
        
        
        
        
    }
    
}
-(UIView*)timeHold{
    if (!_timeHold) {
        

        _timeHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _timeHold.backgroundColor=THIEM_COLOR_DARKER;
        [self addSubview:_timeHold];
        
        _year=[[UILabel alloc]init];
        _year.textColor=[UIColor whiteColor];
        _year.font=SYSTEMFONT(18);
        _year.text=@"1970";
        [_timeHold addSubview:_year];
        [_year mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_timeHold).with.offset(DISTANCE_TO_EDGE*1.5);
            make.leading.equalTo(_timeHold).with.offset(DISTANCE_TO_EDGE*2);
        }];
        
        _month_day=[[UILabel alloc]init];
        _month_day.textColor=[UIColor whiteColor];
        _month_day.font=SYSTEMFONT(25);
        _month_day.text=@"十二月十二日,星期一";
        [_timeHold addSubview:_month_day];
        [_month_day mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_year.mas_bottom).offset(DISTANCE_TO_EDGE*0.2);
            make.leading.equalTo(_year);
        }];
        
        
        _hour=[[UILabel alloc]init];
        _hour.textColor=[UIColor whiteColor];
        _hour.font=SYSTEMFONT(50);
        _hour.attributedText=[self setAttriHour:23 minute:11];
        
        
        [_timeHold addSubview:_hour];
        [_hour mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_timeHold).with.offset(-DISTANCE_TO_EDGE);
            make.trailing.equalTo(_timeHold).with.offset(-DISTANCE_TO_EDGE*2);
        }];
        
        
    }
    return _timeHold;
}

-(NSMutableAttributedString*) setAttriHour:(NSInteger)hour minute:(NSInteger)nminute{
    
    NSString* hourMinute;
    if (hour<12) {
        hourMinute=[NSString stringWithFormat:@"%02zd:%02zd AM",hour,nminute];
    }else{
        hourMinute=[NSString stringWithFormat:@"%02zd:%02zd PM",hour-12,nminute];
    }

    NSMutableAttributedString* attrStr=[[NSMutableAttributedString alloc]initWithString:hourMinute attributes:@{NSFontAttributeName: SYSTEMFONT(50)}];
    [attrStr setAttributes:@{NSFontAttributeName : SYSTEMFONT(20), NSBaselineOffsetAttributeName : @25} range:NSMakeRange(attrStr.length-2, 2)];
    
    return  attrStr;

}

-(UIView*)locationHold{
    if (!_locationHold) {
        _locationHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _locationHold.backgroundColor=[UIColor greenColor];
        [self addSubview:_locationHold];
        
        _myMap=[[MAMapView alloc]initWithFrame:_locationHold.frame];
        [_myMap setZoomLevel:15 animated:YES];
        _myMap.scrollEnabled=NO;
        _myMap.showsCompass=NO;
        _myMap.showsScale=NO;
//        [_myMap setCenterCoordinate:[XYUserInfo userInfo].userLocation.coordinate animated:YES];
        [_locationHold addSubview:_myMap];
        
        
    }
    return _locationHold;
}
-(UIView*)imgHold{
    if (!_imgHold) {
        _imgHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgHold.backgroundColor=[UIColor blueColor];
        [self addSubview:_imgHold];
        
        _imgView=[[UIImageView alloc]initWithFrame:_imgHold.frame];
        [_imgView setContentMode:UIViewContentModeScaleAspectFill];
        _imgView.clipsToBounds=YES;
        [_imgHold addSubview:_imgView];
        
    }
    return _imgHold;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
