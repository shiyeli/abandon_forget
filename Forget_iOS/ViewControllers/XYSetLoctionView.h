//
//  XYSetLoctionView.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentView.h"
@class AMapTip;
@interface XYSetLoctionView : XYParentView

@property(nonatomic,weak)XYNotifyModel* model;

-(void)addNewAddress:(AMapTip*)tip;

@end
