//
//  EventManager.h
//  Forget_iOS
//
//  Created by 111 on 16/10/31.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EventKit/EventKit.h>
@interface EventManager : NSObject

@property(nonatomic,strong)EKEventStore *store;


+(instancetype)shareinstence;

-(void)addEventWithModel:(XYNotifyModel*)model success:(void (^) (BOOL success))sendSuccess;


@end
