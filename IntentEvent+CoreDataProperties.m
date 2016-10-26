//
//  IntentEvent+CoreDataProperties.m
//  Forget_iOS
//
//  Created by 111 on 16/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "IntentEvent+CoreDataProperties.h"

@implementation IntentEvent (CoreDataProperties)

+ (NSFetchRequest<IntentEvent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IntentEvent"];
}

@dynamic eventEndRepeatTime;
@dynamic eventRepeatTime;
@dynamic eventCreateTime;
@dynamic eventID;
@dynamic eventTitle;
@dynamic eventUpTime;
@dynamic eventNoteAtSomeLocation;
@dynamic eventNoteLocationAddress;
@dynamic eventNoteLocationLng;
@dynamic eventNoteLocationLat;
@dynamic eventLevel;
@dynamic eventMarkText;

@end
