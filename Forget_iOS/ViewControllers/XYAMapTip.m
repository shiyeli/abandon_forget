//
//  XYAMapTip.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/12/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAMapTip.h"

@implementation XYAMapTip

- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentTime=[XYTool getTimeLabelFromDate:[NSDate date]];
    }
    return self;
}


@end
