//
//  XYTimeCellModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#define HEIGHT_CELL 60.0

@interface XYTimeCellModel : XYParentModel


@property(nonatomic,assign)CGFloat cellH;

//是否设置
@property(nonatomic,assign)BOOL isSwithOn;

//是否展开
@property(nonatomic,assign)BOOL isSpreadOut;



@end
