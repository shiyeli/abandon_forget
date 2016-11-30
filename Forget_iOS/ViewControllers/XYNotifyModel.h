//
//  XYNotifyModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/24.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#import <AMapSearchKit/AMapSearchKit.h>

typedef enum: NSInteger {
    TimeSetRepeatDay=0,
    TimeSetRepeatWeek,
    TimeSetRepeatMonth,
}TimeSetRepeatCircle;

@interface XYNotifyModel : XYParentModel


/****************提醒信息与图片***************/
@property(nonatomic,copy)NSString* notifyRemark;
@property(nonatomic,copy)NSString* notifyImgUrl;




/****************提醒时间***************/
@property(nonatomic,assign)BOOL haveSetTime;
@property(nonatomic,strong)NSDate* notifyTime;
//设置重复
@property(nonatomic,assign)BOOL haveSetRepeat;
@property(nonatomic,assign)NSInteger frequency;
@property(nonatomic)TimeSetRepeatCircle repeatUnit;
//设置结束重复日期
@property(nonatomic,assign)BOOL haveSetClosingDate;
@property(nonatomic,strong)NSDate* closingDate;




/****************提醒地点***************/
@property(nonatomic,assign)BOOL haveSetLocation;
@property(nonatomic,assign)BOOL isPersonalLocation;
//个人地点
@property(nonatomic,strong)AMapTip* tip;
//常见地点:一类地方
@property(nonatomic,copy)NSString* locationClassifition;
//到达地点提醒
@property(nonatomic,assign)BOOL isArrvialNotify;



@end
