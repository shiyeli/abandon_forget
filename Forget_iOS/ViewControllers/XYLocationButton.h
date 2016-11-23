//
//  XYLocationButton.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/23.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYAnimationViewModel;

@interface XYLocationButton : UIButton

//存储选中的图标及名字
@property(nonatomic,strong)XYAnimationViewModel* selectModel;

//存储本来的图标及名字
@property(nonatomic,strong)XYAnimationViewModel* unselectModel;

@end
