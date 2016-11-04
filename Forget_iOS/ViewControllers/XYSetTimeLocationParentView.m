//
//  XYSetTimeLocationParentView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetTimeLocationParentView.h"

@implementation XYSetTimeLocationParentView


-(XYPowerMarkView*)powerMark{
    if (!_powerMark) {
        _powerMark=[[XYPowerMarkView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64-60)];
        [self addSubview:_powerMark];
        __weak XYSetTimeLocationParentView* weakSelf=self;
        _powerMark.sendBlock=^(id sender){
            weakSelf.needSetting=YES;
        };
    }
    return _powerMark;
}



-(void)setNeedSetting:(BOOL)needSetting{
    _needSetting=needSetting;
    
    if (_needSetting==YES) {
        
        
        
        
        
    }else{
        
        
        
        
        
    }
    
    CATransition* anim=[CATransition animation];
    anim.type=@"kCATransitionFade";
    anim.duration=0.3;
    [self.powerMark.layer addAnimation:anim forKey:nil];
    [self.powerMark setHidden:needSetting];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
