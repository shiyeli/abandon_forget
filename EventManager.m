//
//  EventManager.m
//  Forget_iOS
//
//  Created by 111 on 16/10/31.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "EventManager.h"


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
                    [_eventMgt getReminders];
                    
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

-(void)getReminders{
    NSPredicate *predicate = [_store predicateForRemindersInCalendars:[_store calendarsForEntityType:EKEntityTypeReminder]];
    [_store fetchRemindersMatchingPredicate:predicate completion:^(NSArray<EKReminder *> * _Nullable reminders) {
       [reminders enumerateObjectsUsingBlock:^(EKReminder * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           NSLog(@"the reminder:%@",obj);
           NSLog(@"===");
       }];
    }];
}



-(void)addEventWithModel:(XYNotifyModel*)model success:(void (^) (BOOL success))sendSuccess{
    
    EKReminder *newReminder = [EKReminder reminderWithEventStore:self.store];
    newReminder.title=model.notifyRemark;
    newReminder.calendar = [self.store defaultCalendarForNewReminders];
    
    EKRecurrenceRule* rule=[[EKRecurrenceRule alloc]initRecurrenceWithFrequency:EKRecurrenceFrequencyWeekly interval:3 end:[EKRecurrenceEnd recurrenceEndWithEndDate:model.closingDate]];
    [newReminder addRecurrenceRule:rule];
    
    
    
    
    
    
    NSError *error;
    [self.store saveReminder:newReminder commit:YES error:&error];
    if (error==nil) {
        sendSuccess(YES);
    }else{
        sendSuccess(NO);
    }
    
}


@end
