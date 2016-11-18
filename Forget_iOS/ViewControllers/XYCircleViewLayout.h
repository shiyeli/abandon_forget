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
    WHEEL_ALIGNMEN_TLEFT=0,
    WHEEL_ALIGNMENT_CENTER,
    WHEEL_ALIGNMEN_RIGHT,
}WheelAlignmentType;

@property (readwrite, nonatomic, assign) int itemCount;
@property (readwrite, nonatomic, assign) WheelAlignmentType alignType;
@property (readwrite, nonatomic, assign) CGPoint center;
@property (readwrite, nonatomic, assign) CGFloat offset;
@property (readwrite, nonatomic, assign) CGFloat itemHeight;
@property (readwrite, nonatomic, assign) CGFloat xOffset;
@property (readwrite, nonatomic, assign) CGSize cellSize;
@property (readwrite, nonatomic, assign) CGFloat spacing;
@property (readwrite, nonatomic, assign) CGFloat radius;
@property (readonly, nonatomic, strong) NSIndexPath *currentIndexPath;

- (instancetype)initWithRadius:(CGFloat)radius aliginType:(WheelAlignmentType)alignType cellSize:(CGSize)cellSize xOffset:(CGFloat)xOffset spacing:(CGFloat)spacing;



@end
