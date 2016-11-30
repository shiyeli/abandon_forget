//
//  XYNotifyModel.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/24.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYNotifyModel.h"

@implementation XYNotifyModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSMutableArray* arrM=[NSMutableArray array];
        for (int i=0; i<5; i++) {
            NSString* temStr=[NSString stringWithFormat:@"%d",i+1];
            [arrM addObject:temStr];
        }
        _frequencyArr=[NSArray arrayWithArray:arrM];
        _repeatUnitArr=TimeSetRepeatCircleArr;
        
    }
    return self;
}

@end
