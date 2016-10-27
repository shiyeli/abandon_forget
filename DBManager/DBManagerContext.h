//
//  DBManagerContext.h
//  Forget_iOS
//
//  Created by 111 on 16/10/27.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntentEvent+CoreDataClass.h"

@interface DBManagerContext : NSObject
+ (void)intentEvent_insertItem:(NSString *)title;

+ (NSArray <IntentEvent *> *)intentEvent_allIntentEvent;
@end
