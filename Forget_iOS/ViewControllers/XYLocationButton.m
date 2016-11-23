//
//  XYLocationButton.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/23.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYLocationButton.h"
#import "XYAnimationViewModel.h"
@implementation XYLocationButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setSelectModel:(XYAnimationViewModel *)selectModel{
    if (selectModel) {
        _selectModel=selectModel;
        [self setTitle:_selectModel.name forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:_selectModel.img] forState:UIControlStateNormal];
    }else{
        if (_unselectModel) {
            [self setTitle:_unselectModel.name forState:UIControlStateNormal];
            [self setBackgroundImage:[UIImage imageNamed:_unselectModel.img] forState:UIControlStateNormal];
        }
    }
}

@end
