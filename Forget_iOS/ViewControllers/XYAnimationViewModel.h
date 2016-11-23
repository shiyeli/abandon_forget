//
//  XYAnimationViewModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/16.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"

@interface XYAnimationViewModel : XYParentModel

@property(nonatomic,copy)NSString* img;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign) BOOL isNameLeft;

@end
