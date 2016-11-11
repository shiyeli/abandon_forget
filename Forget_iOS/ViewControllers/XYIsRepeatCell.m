//
//  XYIsRepeatCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYIsRepeatCell.h"

@implementation XYIsRepeatCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCustomView];
    }
    return self;
}

-(void)setCustomView{
    _repeatLab=[[UILabel alloc]init];
    _repeatLab.textColor=[UIColor whiteColor];
    _repeatLab.text=@"每周三";
    _repeatLab.font=SYSTEMFONT(45);
    _repeatLab.textAlignment=NSTextAlignmentCenter;
    [self.titleView addSubview:_repeatLab];
    [_repeatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.titleView);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
