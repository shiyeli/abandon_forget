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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setViews];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setViews];
}
-(void)setViews{
    [self setContentMode:UIViewContentModeScaleAspectFill];
    self.clipsToBounds=YES;
    
    removeBtn=[[UIButton alloc]init];
    [removeBtn setImage:[UIImage imageNamed:@"delete_notify_img"] forState:UIControlStateNormal];
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
    
    UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addImg:)];
    [self addGestureRecognizer:tap];
}

-(void)removeImg{
    
    [self setImage:nil];
    //转场动画
    CATransition* anim=[CATransition animation];
    
    anim.type=@"kCATransitionFade";
    anim.duration=0.2;
    anim.subtype=kCATransitionFromRight;
    [self.layer addAnimation:anim forKey:nil];
    
    
}
-(void)addImg:(UIButton*)sender{
    if (![sender isKindOfClass:[UIButton class]]) {
        if (!self.image) {
            return;
        }
    }
    
    if (self.callBack) {
        self.callBack(sender);
    }
}


-(void)setImage:(UIImage *)image{
    [super setImage:image];
    //removeBtn.hidden=!(BOOL)image;
    addBtn.hidden=(BOOL)image;
    if (image) {
        [XYTool transitionAnimationWhater];
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
