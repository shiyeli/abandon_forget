//
//  XYParentView.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SendViewBlock)(id sender);


@interface XYParentView : UIView

@property (nonatomic,copy)SendViewBlock sendBlock;

@end
