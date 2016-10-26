//
//  IntentEvent+CoreDataProperties.h
//  Forget_iOS
//
//  Created by 111 on 16/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "IntentEvent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IntentEvent (CoreDataProperties)

+ (NSFetchRequest<IntentEvent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *eventEndRepeatTime;
@property (nullable, nonatomic, copy) NSDate *eventRepeatTime;
@property (nullable, nonatomic, copy) NSDate *eventCreateTime;
@property (nonatomic) int32_t eventID;
@property (nullable, nonatomic, copy) NSString *eventTitle;
@property (nullable, nonatomic, copy) NSDate *eventUpTime;
@property (nonatomic) BOOL eventNoteAtSomeLocation;
@property (nullable, nonatomic, copy) NSString *eventNoteLocationAddress;
@property (nonatomic) float eventNoteLocationLng;
@property (nonatomic) float eventNoteLocationLat;
@property (nonatomic) int16_t eventLevel;
@property (nullable, nonatomic, copy) NSString *eventMarkText;

@end

NS_ASSUME_NONNULL_END
