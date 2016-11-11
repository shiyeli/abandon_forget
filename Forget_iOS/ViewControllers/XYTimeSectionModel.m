//
//  XYTimeSectionModel.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/11.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeSectionModel.h"

@implementation XYTimeSectionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        _arrM=[NSMutableArray array];
    }
    return self;
}

-(void)setSwitchIsOpen:(BOOL)switchIsOpen{
    _switchIsOpen=switchIsOpen;
    if (_mySwitch) {
        [_mySwitch setOn:switchIsOpen];
    }
    
    for (XYTimeCellModel* model in _arrM) {
        model.isSwitchOn=switchIsOpen;
        model.isSpreadOut=NO;
    }
}

@end
