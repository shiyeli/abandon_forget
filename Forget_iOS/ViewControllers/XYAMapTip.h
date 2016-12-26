//
//  XYAMapTip.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/12/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <AMapSearchKit/AMapSearchKit.h>

@interface XYAMapTip : AMapSearchObject

//时间戳
@property(nonatomic,copy)NSString* currentTime;


@property (nonatomic, copy) NSString     *uid; //!< poi的id
@property (nonatomic, copy) NSString     *name; //!< 名称
@property (nonatomic, copy) NSString     *adcode; //!< 区域编码
@property (nonatomic, copy) NSString     *district; //!< 所属区域
@property (nonatomic, copy) NSString     *address; //!< 地址
@property (nonatomic, copy) AMapGeoPoint *location; //!< 位置

@property (nonatomic, assign) CGFloat latitude; //!< 纬度（垂直方向）
@property (nonatomic, assign) CGFloat longitude; //!< 经度（水平方向）

@end
