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
    CGPoint center;
    CGFloat intevalAngle;
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
                    
                    @{@"img":@"hospital_btn",@"name":@"菜市场"},
                    @{@"img":@"park_btn",@"name":@"快时代"},
                    @{@"img":@"bank_btn",@"name":@"梦思特"}];
        
        personArr=@[@{@"img":@"home_btn",@"name":@"家"},
                       @{@"img":@"company_btn",@"name":@"公司"},
                       @{@"img":@"exercise_btn",@"name":@"健身房"},
                       @{@"img":@"girl_home",@"name":@"女朋友家"},
                       @{@"img":@"parents_home",@"name":@"父母家"}];
        
        center=CGPointMake(Main_Screen_Width*0.5, Main_Screen_Height*0.5);
        intevalAngle=M_PI/4.0f;
        
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
    
    CGRect frame;
    if (_isCommomAddress) {
        frame=CGRectMake(-Main_Screen_Width*0.35, 0, Main_Screen_Width, Main_Screen_Height);
    }else{
        frame=CGRectMake(Main_Screen_Width*0.35, 0, Main_Screen_Width, Main_Screen_Height);
    }
    
    holdView=[[UIView alloc]initWithFrame:frame];
    holdView.backgroundColor=[UIColor clearColor];
    [self addSubview:holdView];
    
    UIButton* closeBtn=[[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:(_isCommomAddress?@"close_common":@"close_personal")] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAnimationView) forControlEvents:UIControlEventTouchUpInside];
    [holdView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(holdView);
        
    }];
    
    
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
        
        tempAngle =_isCommomAddress?intevalAngle * i:(intevalAngle * i+M_PI);
        btnCenterX = centerX + radius * sin(tempAngle);
        btnCenterY = centerY - radius * cos(tempAngle);
        
        UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, btnHeight)];
        tempBtn.tag =kTag+i;
        tempBtn.center = CGPointMake(btnCenterX, btnCenterY);
        [tempBtn setImage:[UIImage imageNamed:model.img] forState:UIControlStateNormal];
        //[tempBtn setTitle:model.name forState:UIControlStateNormal];
        [holdView addSubview:tempBtn];
        
        UILabel* name=[[UILabel alloc]init];
        name.text=model.name;
        name.font=SYSTEMFONT(12);
        name.textColor=[UIColor whiteColor];
        [holdView addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tempBtn);
            if (_isCommomAddress) {
                make.leading.equalTo(tempBtn.mas_trailing);
            }else{
                make.trailing.equalTo(tempBtn.mas_leading);
            }
        }];
        
    }
    
    
    
}

//求相对中点的角度,12点钟为0度,顺时针旋转
-(CGFloat)getAnglePointToCenter:(CGPoint)point{
    
    
    //NSLog(@"%f  %f",touchP.x,touchP.y);
    
    //距离中点半径
    CGFloat touchPRadius=sqrt(pow(point.x-center.x, 2)+pow(point.y-center.y, 2));
    
    if (touchPRadius==0) {
        return 0;
    }
    
    //计算触摸点与中点连线与y轴负方向(向上)的夹角
    CGFloat angel=asin((point.x-center.x)/touchPRadius);
    if (point.y>center.y) {//触摸点在中点的下面
        angel=M_PI-angel;
        
    }else{
        if (angel<0) {
            angel=M_PI*2+angel;
        }
    }
    
    //NSLog(@"%f",angel*180/M_PI);

    return angel;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    UITouch* touch=[touches anyObject];
    CGPoint touchP=[touch locationInView:holdView];
    
    _lastAngle=[self getAnglePointToCenter:touchP];
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    _currentAngle=[self getAnglePointToCenter:[[touches anyObject] locationInView:holdView]];
    
    
    CGFloat changeAngle=_currentAngle-_lastAngle;
    CGFloat btnCenterX;
    CGFloat btnCenterY;
    UIButton* btn=[holdView viewWithTag:kTag+0];
    CGFloat tempAngle=[self getAnglePointToCenter:btn.center];
    
    _lastAngle = fmod(_lastAngle + changeAngle, 2 * M_PI);//对当前角度取模
    
    for (int i=0; i<self.dataArray.count; i++) {
        
        UIButton* btn=[holdView viewWithTag:kTag+i];
        
        btnCenterX=center.x+radius*sin(tempAngle+i*intevalAngle+changeAngle);
        btnCenterY=center.y-radius*cos(tempAngle+i*intevalAngle+changeAngle);
        btn.center=CGPointMake(btnCenterX, btnCenterY);
        
    }
    //_lastAngle=_currentAngle;
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
