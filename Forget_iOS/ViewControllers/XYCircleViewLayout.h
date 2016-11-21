//
//  XYCircleViewLayout.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/17.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCircleViewLayout : UICollectionViewLayout


typedef enum : NSInteger {
    WHEEL_ALIGNMEN_LEFT=0,
    WHEEL_ALIGNMEN_RIGHT,
}WheelAlignmentType;


@property (readwrite, nonatomic, assign) NSInteger itemCount;

//半圆在左边还是右边
@property (readwrite, nonatomic, assign) WheelAlignmentType alignType;

@property (readwrite, nonatomic, assign) CGSize cellSize;
@property (readwrite, nonatomic, assign) CGFloat spacing;
//itemHeight=cellSize.height+spacing
@property (readwrite, nonatomic, assign) CGFloat itemHeight;

//半圆半径
@property (readwrite, nonatomic, assign) CGFloat radius;
@property (nonatomic,assign) CGPoint circleCenter;

@property (readonly, nonatomic, strong) NSIndexPath *currentIndexPath;

- (instancetype)initWithRadius:(CGFloat)radius aliginType:(WheelAlignmentType)alignType cellSize:(CGSize)cellSize spacing:(CGFloat)spacing;



@end
