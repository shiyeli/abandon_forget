//
//  XYNewNotifyImgView.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/25.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack)(id sender);

@interface XYNewNotifyImgView : UIImageView

@property(nonatomic,copy)CallBack callBack;

@end
