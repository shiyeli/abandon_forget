//
//  XYAnimationView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/16.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAnimationView.h"

@implementation XYAnimationView
{
    NSArray* commonArr;
    NSArray* personArr;
    UIView* holdView;
    CGFloat _lastAngle;
    CGFloat _currentAngle;
    CGFloat radius;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        commonArr=@[@{@"img":@"restaurant_btn",@"name":@"餐饮"},
                       @{@"img":@"supermarket_btn",@"name":@"超市"},
                       @{@"img":@"hospital_btn",@"name":@"医院"},
                       @{@"img":@"park_btn",@"name":@"停车场"},
                    @{@"img":@"bank_btn",@"name":@"银行"},
                    
                    @{@"img":@"hospital_btn",@"name":@"医院"},
                    @{@"img":@"park_btn",@"name":@"停车场"},
                    @{@"img":@"bank_btn",@"name":@"银行"}];
        
        personArr=@[@{@"img":@"home_btn",@"name":@"家"},
                       @{@"img":@"company_btn",@"name":@"公司"},
                       @{@"img":@"exercise_btn",@"name":@"健身房"},
                       @{@"img":@"girl_home",@"name":@"女朋友家"},
                       @{@"img":@"parents_home",@"name":@"父母家"}];
        
        
        
        
    }
    return self;
}

-(void)setIsCommomAddress:(BOOL)isCommomAddress{
    _isCommomAddress=isCommomAddress;
    
    self.dataArray=[NSMutableArray array];
    for (NSDictionary* dic in (isCommomAddress?commonArr:personArr)) {
        XYAnimationViewModel* model=[[XYAnimationViewModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    [self refreshAnimationView];
}

-(void)refreshAnimationView{
    
    for (UIView* obj in self.subviews) {
        [obj removeFromSuperview];
    }
    
    
    holdView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
    holdView.backgroundColor=[UIColor clearColor];
    [self addSubview:holdView];
    
    UIButton* closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:(_isCommomAddress?@"close_common":@"close_personal")] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAnimationView) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(holdView);
        
    }];
    
    CGFloat intevalAngle=M_PI/4.0f;
    CGFloat tempAngle=0;
    radius=Main_Screen_Width*0.4;
    CGFloat centerX=Main_Screen_Width*0.5;
    CGFloat centerY=Main_Screen_Height*0.5;
    CGFloat btnCenterX;
    CGFloat btnCenterY;
    CGFloat btnWidth=70;
    CGFloat btnHeight=70;
    
    for (int i=0; i<self.dataArray.count; i++) {
        XYAnimationViewModel* model=self.dataArray[i];
        
        tempAngle = intevalAngle * i;
        btnCenterX = centerX + radius * sin(tempAngle);
        btnCenterY = centerY - radius * cos(tempAngle);
        
        UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
        tempBtn.tag =i;
        tempBtn.center = CGPointMake(btnCenterX, btnCenterY);
        [tempBtn setImage:[UIImage imageNamed:model.img] forState:UIControlStateNormal];
        //[tempBtn setTitle:model.name forState:UIControlStateNormal];
        [holdView addSubview:tempBtn];
        
        UILabel* name=[[UILabel alloc]init];
        name.text=model.name;
        name.tag=100+i;
        [holdView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tempBtn);
            make.leading.equalTo(tempBtn.mas_trailing);
        }];
        
    }
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    CGPoint touchP=[touch locationInView:holdView];
    //NSLog(@"%f  %f",touchP.x,touchP.y);
    
    CGPoint center=CGPointMake(Main_Screen_Width*0.5, Main_Screen_Height*0.5);
    //计算触摸点与中点连线与y轴负方向(向上)的夹角
    
    _lastAngle=asin((touchP.x-center.x)/sqrt(pow(touchP.x-center.x, 2)+pow(touchP.y-center.y, 2)));
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch=[touches anyObject];
    CGPoint touchP=[touch locationInView:holdView];
    //NSLog(@"%f  %f",touchP.x,touchP.y);
    
    CGPoint center=CGPointMake(Main_Screen_Width*0.5, Main_Screen_Height*0.5);
    //计算触摸点与中点连线与y轴负方向(向上)的夹角
    
    _currentAngle=asin((touchP.x-center.x)/sqrt(pow(touchP.x-center.x, 2)+pow(touchP.y-center.y, 2)));
    
    CGFloat changeAngle=_currentAngle-_lastAngle;
    NSLog(@"%lf",changeAngle);
    
    CGFloat btnCenterX;
    CGFloat btnCenterY;
    
    for (int i=0; i<self.dataArray.count; i++) {
        UIButton* btn=[holdView viewWithTag:i];
        
        CGFloat tempAngle=asin((btn.center.x-center.x)/sqrt(pow(btn.center.x-center.x, 2)+pow(btn.center.y-center.y, 2)));
        NSLog(@"%f",tempAngle*180/M_PI);
        
        btnCenterX=center.x+radius*sin(tempAngle+changeAngle);
        btnCenterY=center.y+radius*cos(tempAngle+changeAngle);
        btn.center=CGPointMake(btnCenterX, btnCenterY);
        
        UILabel* lab=[holdView viewWithTag:100+i];
        
        
    }
    
    
    _lastAngle=_currentAngle;
}


-(void)closeAnimationView{
     [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
