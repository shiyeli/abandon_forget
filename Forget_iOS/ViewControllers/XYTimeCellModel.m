//
//  XYTimeCellModel.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeCellModel.h"

@implementation XYTimeCellModel

-(void)setIsSwithOn:(BOOL)isSwithOn{
    _isSwithOn=isSwithOn;
    
    if (isSwithOn) {
        _cellH=TIME_CELL_HEIGHT;
    }else{
        _cellH=0;
    }
}

@end
