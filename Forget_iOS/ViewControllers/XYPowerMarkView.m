//
//  XYPowerMarkView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYPowerMarkView.h"

@implementation XYPowerMarkView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInterface];
    }
    return self;
}

-(void)setUserInterface{
    
    self.backgroundColor=THIEM_COLOR;
    
    UIButton * powerBtn=[[UIButton alloc]init];
    [powerBtn setBackgroundImage:[UIImage imageNamed:@"big_time"] forState:UIControlStateNormal];
    [powerBtn addTarget:self action:@selector(powerClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:powerBtn];
    [powerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@105);
        make.height.equalTo(@105);
        make.center.equalTo(self);
    }];

}

-(void)powerClick:(id)sender{
    if (self.sendBlock) {
        self.sendBlock(sender);
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
