//
//  XYNotifyListHeaderView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/24.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYNotifyListHeaderView.h"


@interface XYNotifyListHeaderView ()

@property(nonatomic,strong)UIView* timeHold;
@property(nonatomic,strong)UIView* locationHold;
@property(nonatomic,strong)UIView* imgHold;

@end

@implementation XYNotifyListHeaderView

-(void)setModel:(XYNotifyModel *)model{
    _model=model;
    
    if (_model.haveSetTime) {
        [self bringSubviewToFront:self.timeHold];
    }else if (_model.haveSetLocation&&_model.isPersonalLocation){
        [self bringSubviewToFront:self.locationHold];
    }else{
         [self bringSubviewToFront:self.imgHold];
    }
    
}
-(UIView*)timeHold{
    if (!_timeHold) {
        _timeHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _timeHold.backgroundColor=[UIColor redColor];
        [self addSubview:_timeHold];
    }
    return _timeHold;
}
-(UIView*)locationHold{
    if (!_locationHold) {
        _locationHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _locationHold.backgroundColor=[UIColor greenColor];
        [self addSubview:_locationHold];
    }
    return _locationHold;
}
-(UIView*)imgHold{
    if (!_imgHold) {
        _imgHold=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _imgHold.backgroundColor=[UIColor blueColor];
        [self addSubview:_imgHold];
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
