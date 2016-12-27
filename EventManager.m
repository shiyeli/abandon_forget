//
//  EventManager.m
//  Forget_iOS
//
//  Created by 111 on 16/10/31.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "EventManager.h"
#import <EventKit/EventKit.h>
static  EKEventStore *store = nil;
@implementation EventManager
//+ (void)load{
//    store = [[EKEventStore alloc] init];
//    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusNotDetermined) {
//        [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
//            if (granted) {
//                [EventManager getReminders];
//                
//            }
//            else{
//                NSLog(@"用户拒绝了授权访问提醒事项...");
//            }
//        }];
//    }
//    else{
//         [EventManager getReminders];
//    }
//   
//}
//
//+ (void)getReminders{
//    NSPredicate *predicate = [store predicateForRemindersInCalendars:[store calendarsForEntityType:EKEntityTypeReminder]];
//    [store fetchRemindersMatchingPredicate:predicate completion:^(NSArray<EKReminder *> * _Nullable reminders) {
//       [reminders enumerateObjectsUsingBlock:^(EKReminder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           NSLog(@"the reminder:%@",obj);
//           NSLog(@"===");
//       }];
//    }];
//}
@end
