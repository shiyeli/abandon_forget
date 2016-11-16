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
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer* tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
        commonArr=@[@{@"img":@"restaurant_btn",@"name":@"餐饮"},
                       @{@"img":@"supermarket_btn",@"name":@"超市"},
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
-(void)tap:(UITapGestureRecognizer*)tap{
    [self removeFromSuperview];
}

-(void)setIsCommomAddress:(BOOL)isCommomAddress{
    _isCommomAddress=isCommomAddress;
    
    for (NSDictionary* dic in (isCommomAddress?commonArr:personArr)) {
        XYAnimationViewModel* model=[[XYAnimationViewModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    [self refreshAnimationView];
}

-(void)refreshAnimationView{
    


}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
