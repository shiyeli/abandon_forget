//
//  XYNewNotifyImgView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/25.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYNewNotifyImgView.h"

@implementation XYNewNotifyImgView
{
    UIButton * removeBtn;
    UIButton * addBtn;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    removeBtn=[[UIButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"search_clear"] forState:UIControlStateNormal];
    [removeBtn addTarget:self action:@selector(removeImg) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeBtn];
    self.userInteractionEnabled=YES;
    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.trailing.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    removeBtn.hidden=YES;
    
    addBtn=[[UIButton alloc]init];
    [addBtn setImage:[UIImage imageNamed:@"take_photo"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addImg:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addBtn];
    self.userInteractionEnabled=YES;
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@87);
        make.height.equalTo(@87);
    }];
    
}
-(void)removeImg{
    [self setImage:nil];
    
}
-(void)addImg:(UIButton*)sender{
    if (self.callBack) {
        self.callBack(sender);
    }
}
-(void)setImage:(UIImage *)image{
    [super setImage:image];
    
    removeBtn.hidden=!(BOOL)image;
    addBtn.hidden=(BOOL)image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
