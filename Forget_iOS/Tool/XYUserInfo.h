//
//  XYUserInfo.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface XYUserInfo : NSObject<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *mLocationManager;

@property(nonatomic,strong)CLLocation* userLocation;

@property(nonatomic,strong)NSString* userCurrentCity;



+ (instancetype)userInfo;

@end
