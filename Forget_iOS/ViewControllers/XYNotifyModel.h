//
//  XYNotifyModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/24.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface XYNotifyModel : XYParentModel

@property(nonatomic,assign)BOOL haveSetTime;

@property(nonatomic,assign)BOOL haveSetLocation;
@property(nonatomic,assign)BOOL isPersonalLocation;

@property(nonatomic,copy)NSString* notifyRemark;
@property(nonatomic,copy)NSString* notifyImgUrl;
@property(nonatomic,strong)AMapTip* tip;


@end
