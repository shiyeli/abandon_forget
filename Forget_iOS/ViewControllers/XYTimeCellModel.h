//
//  XYTimeCellModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#define TIME_CELL_HEIGHT 75.0
#define TIME_CELL_HEIGHT_SPREADOUT 350.0

@interface XYTimeCellModel : XYParentModel


@property(nonatomic,assign)CGFloat cellH;

//记录当前cell所在的位置
@property(nonatomic,strong)NSIndexPath* indexPath;

//是否设置
@property(nonatomic,assign)BOOL isSwithOn;

//是否展开
@property(nonatomic,assign)BOOL isSpreadOut;




@end
