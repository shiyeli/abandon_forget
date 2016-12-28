//
//  XYPOINearbySearch.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/12/28.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYPOINearbySearch : NSObject<AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI *search;


+(instancetype)nearbySearch;


- (void)searchPoiByUserLocation:(XYAMapTip*)tip notifyModel:(XYNotifyModel*)model;

@end
