//
//  XYUserInfo.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYUserInfo.h"
#import "XYPOINearbySearch.h"

static XYUserInfo * _userInfo;
@implementation XYUserInfo
+ (void)load
{
    /**
     *  初始化对象
     */
    [XYUserInfo userInfo];
}

+ (instancetype)userInfo
{
    if (_userInfo==nil){
        _userInfo=[[XYUserInfo alloc]init];
        [_userInfo initCustomObject];
        
    }
    return _userInfo;
}

-(void)initCustomObject{
    //定位管理器
    if (CLLocationManager.locationServicesEnabled) {
        _mLocationManager = [[CLLocationManager alloc] init];
        _mLocationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
            [_mLocationManager requestAlwaysAuthorization];  //调用了这句,就会弹出允许框了.
        }
        
    }else{
        NSLog(@"定位服务未打开");
    }
    
    _userTip=[[XYAMapTip alloc]init];
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:kGET_USER_LOCATION_FREQUENCY target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

-(void)timerAction:(NSTimer*)timer{
    [_mLocationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败...");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation * location = locations[0];
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder  reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * place = placemarks[0];
        NSLog(@"当前位置:%@%@%@",place.subLocality,place.thoroughfare,place.name);
        _userCurrentCity=place.locality;
        _userLocation=location;
        
        _userTip.name=kUSER_CURRENT_LOCATION_STRING;
        _userTip.address=[NSString stringWithFormat:@"%@%@%@",place.subLocality,place.thoroughfare,place.name];
        
        AMapGeoPoint* point=[[AMapGeoPoint alloc]init];
        point.latitude=location.coordinate.latitude;
        point.longitude=location.coordinate.longitude;
        _userTip.location=point;

        if (_userTip&&place.name.length>0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kUSER_CURRENT_LOCATION_NOTIFY object:nil userInfo:@{@"userTip":_userTip}];
        }
        
        [self notifyUserLocationEvent:_userTip];

    }];
    
    [_mLocationManager stopUpdatingLocation];
}

/**
 *   提醒用户地点事件
 */
-(void)notifyUserLocationEvent:(XYAMapTip*)tip{
    //获取数据库
 //   NSArray* notifyList=[[LBSQLManager sharedInstace]selectModelArrayInDatabase:@"XYNotifyModel"];
//    for (XYNotifyModel* model in notifyList) {
//        if (!model.isComplished&&model.haveSetLocation&&!model.isPersonalLocation) {
//            //一类地点
//            [[XYPOINearbySearch nearbySearch] searchPoiByUserLocation:tip notifyModel:model];
//            
//        }
//    }
}


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied){
        NSLog(@"请开启定位服务");
    }else{
        _mLocationManager.desiredAccuracy = kCLLocationAccuracyBest; //控制定位精度,越高耗电量越大。
        _mLocationManager.distanceFilter =1; //控制定位服务更新频率。单位是“米”
        [_mLocationManager startUpdatingLocation];
    }
}

@end
