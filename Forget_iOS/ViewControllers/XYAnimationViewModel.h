//
//  XYAnimationViewModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/16.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface XYAnimationViewModel : XYParentModel

@property(nonatomic,copy)NSString* img;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)NSInteger row;

@property(nonatomic,assign) BOOL isNameLeft;

@property(nonatomic,strong)XYAMapTip* tip;

@end
