//
//  EventManager.m
//  Forget_iOS
//
//  Created by 111 on 16/10/31.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "EventManager.h"
#define my_EKCalendarTitle @"imnesia"

static EventManager* _eventMgt;

@implementation EventManager

+ (void)load{
    
    [EventManager shareinstence];
}


+(instancetype)shareinstence{
    
    
    if (_eventMgt==nil) {
        _eventMgt=[[EventManager alloc]init];
    }
    
    
    return _eventMgt;
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _store = [[EKEventStore alloc] init];
        if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] == EKAuthorizationStatusNotDetermined) {
            [_store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    //[_eventMgt getReminders];
                    [_eventMgt createCalendar];
                }
                else{
                    NSLog(@"用户拒绝了授权访问提醒事项...");
                }
            }];
        }
        else{
            [_eventMgt getReminders];
        }

    }
    return self;
}
-(void)createCalendar{

    BOOL shouldAdd = YES;
    EKCalendar *calendar;
    for (EKCalendar *ekcalendar in [self.store calendarsForEntityType:EKEntityTypeReminder]) {
        if ([ekcalendar.title isEqualToString:my_EKCalendarTitle]) {
            shouldAdd = NO;
            calendar = ekcalendar;
        }
    }
    if (shouldAdd) {
        EKSource *localSource = nil;
        for (EKSource *source in self.store.sources)
        {
            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
            {
                localSource = source;
                break;
            }
        }
        if (localSource == nil)
        {
            for (EKSource *source in self.store.sources) {
                if (source.sourceType == EKSourceTypeLocal)
                {
                    localSource = source;
                    break;
                }
            }
        }
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.store];
        calendar.source = localSource;
        calendar.title = my_EKCalendarTitle;//自定义日历标题
        calendar.CGColor = [UIColor greenColor].CGColor;//自定义日历颜色
        NSError* error;
        [self.store saveCalendar:calendar commit:YES error:&error];
        NSLog(@"创建日历错误信息: %@",error);
        if (error==nil) {
            self.calendar=calendar;
        }
    }

}


-(void)getReminders{
//    NSPredicate *predicate = [_store predicateForRemindersInCalendars:[_store calendarsForEntityType:EKEntityTypeReminder]];
//    [_store fetchRemindersMatchingPredicate:predicate completion:^(NSArray<EKReminder *> * _Nullable reminders) {
//       [reminders enumerateObjectsUsingBlock:^(EKReminder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//           NSLog(@"the reminder:%@",obj);
//           NSLog(@"===");
//       }];
//    }];
    
    for (EKCalendar* cal in [self.store calendarsForEntityType:EKEntityTypeReminder]) {
        if ([cal.title isEqualToString:my_EKCalendarTitle]) {
            self.calendar=cal;
        }
    }
}



-(void)addEventWithModel:(XYNotifyModel*)model success:(void (^) (BOOL success))sendSuccess{
    
    if ([EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder] != EKAuthorizationStatusAuthorized) {
        NSLog(@"用户未授权");
    }
    
    
    
    
    
    
    EKReminder *newReminder = [EKReminder reminderWithEventStore:self.store];
    newReminder.title=model.notifyRemark;

    newReminder.calendar = [self.store defaultCalendarForNewReminders];
//    if (self.calendar) {
//        //self.calendar;
//    } else{
//        NSLog(@"self.calendar 为空");
//    } //[self.store defaultCalendarForNewReminders];
    
    EKRecurrenceRule* rule;
    
    if (model.haveSetTime) {//有时间提醒
        
        EKAlarm* alarm=[EKAlarm alarmWithAbsoluteDate:model.notifyTime];
        [newReminder addAlarm:alarm];
        
        if (model.haveSetRepeat==NO) {//只提醒一次
            
        }else {//要重复
            rule=[[EKRecurrenceRule alloc]initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:3 end:[EKRecurrenceEnd recurrenceEndWithEndDate:model.closingDate]];
            [newReminder addRecurrenceRule:rule];
        }
    }else if(model.haveSetTime==NO&&model.haveSetLocation==YES){//只有地点提醒
        if (model.isPersonalLocation){//如果是指定地点
            sendSuccess(NO);
            return;
        }else{
            //一类地点???
            sendSuccess(NO);
            return;
        }
    }else if (model.haveSetTime&&model.haveSetLocation){
        //时间地点提醒
        sendSuccess(NO);
        return;
    }

    
    
    
    
    
    
    
    
    
    
    
    
    NSError *error;
    [self.store saveReminder:newReminder commit:YES error:&error];
    if (error==nil) {
        sendSuccess(YES);
    }else{
        sendSuccess(NO);
    }
    NSLog(@"保存提醒错误:%@",error);
}


@end
