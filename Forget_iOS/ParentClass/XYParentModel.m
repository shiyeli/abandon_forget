//
//  XYParentModel.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"

@implementation XYParentModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"UndefinedKey-------%@",key);
}

@end
