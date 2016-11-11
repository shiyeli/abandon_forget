//
//  XYTimeCellModel.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeCellModel.h"

@implementation XYTimeCellModel



-(void)setIsSpreadOut:(BOOL)isSpreadOut{
    if (_isSwitchOn) {
        _isSpreadOut=isSpreadOut;
        _cellH=isSpreadOut?TIME_CELL_HEIGHT_SPREADOUT:TIME_CELL_HEIGHT;
    }
}

-(void)setIsSwitchOn:(BOOL)isSwitchOn{
    _isSwitchOn=isSwitchOn;
    _isSpreadOut=NO;
    _cellH=isSwitchOn?TIME_CELL_HEIGHT:0;
    
}

@end
