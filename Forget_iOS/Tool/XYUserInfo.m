//
//  XYUserInfo.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYUserInfo.h"
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
    
    //定时器
    [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

-(void)timerAction:(NSTimer*)timer{
    [_mLocationManager startUpdatingLocation];
}

#pragma mark 跟踪定位代理方法，每次位置发生变化即会执行（只要定位到相应位置）
/**
 *  加载地理位置定位框架
 */
- (void) loadLocationManager
{
    
    //定位管理器
    if (CLLocationManager.locationServicesEnabled) {
        _mLocationManager = [[CLLocationManager alloc] init];
        _mLocationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
            
            [_mLocationManager requestWhenInUseAuthorization];  //调用了这句,就会弹出允许框了.
        }
        
    }else{
        NSLog(@"定位服务未打开");
    }
    
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
        NSLog(@"当前位置: %@ %@",place.name,place.locality );
        _userCurrentCity=place.locality;
    }];
    _userLocation=location;
    [[NSNotificationCenter defaultCenter]postNotificationName:kUSER_CURRENT_LOCATION object:location];
    [_mLocationManager stopUpdatingLocation];
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
