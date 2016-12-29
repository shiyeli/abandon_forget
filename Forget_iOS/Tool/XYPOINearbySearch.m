//
//  XYPOINearbySearch.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/12/28.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYPOINearbySearch.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

static XYPOINearbySearch *  _nearbySearch;

@implementation XYPOINearbySearch
{
    XYAMapTip* _userTip;
    XYNotifyModel* _model;
}
+(void)load{
    
    [XYPOINearbySearch nearbySearch];
}

+(instancetype)nearbySearch{
    if (!_nearbySearch) {
        _nearbySearch=[[XYPOINearbySearch alloc]init];
    }
    return _nearbySearch;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [AMapServices sharedServices].apiKey=AMapApiKey;
        _search= [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return self;
}


/* 根据中心点坐标来搜周边的POI. */
- (void)searchPoiByUserLocation:(XYAMapTip*)tip notifyModel:(XYNotifyModel *)model
{
    
    _userTip=tip;
    _model=model;
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:tip.location.latitude longitude:tip.location.longitude];
    request.keywords            = model.locationClassifition;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.search AMapPOIAroundSearch:request];
}

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    

    
    [response.pois enumerateObjectsUsingBlock:^(AMapPOI *obj, NSUInteger idx, BOOL *stop) {

        
        CLLocation* userLocation=[[CLLocation alloc]initWithLatitude:_userTip.location.latitude longitude:_userTip.location.longitude];
        CLLocation* searchLocation=[[CLLocation alloc]initWithLatitude:obj.location.latitude longitude:obj.location.longitude];
        double distance=[userLocation distanceFromLocation:searchLocation];
        
        if (distance<100.0) {//500米范围内提醒
            NSLog(@"附近有 :  %@",obj.name);
            NSString* broadcastStr=[[NSString alloc]initWithFormat:@"这附近有%@,%@",obj.name,_model.notifyRemark];
            
            
            
        }
        
    }];
}



@end
