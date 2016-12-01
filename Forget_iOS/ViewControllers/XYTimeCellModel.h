//
//  XYTimeCellModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#define TIME_CELL_HEIGHT 70.0
#define TIME_CELL_HEIGHT_SPREADOUT (TIME_CELL_HEIGHT+Main_Screen_Width+40)


@interface XYTimeCellModel : XYParentModel


@property(nonatomic,assign)CGFloat cellH;

//记录当前cell所在的位置
@property(nonatomic,strong)NSIndexPath* indexPath;


//是否打开
@property(nonatomic,assign)BOOL isSwitchOn;

//是否展开
@property(nonatomic,assign)BOOL isSpreadOut;


//提醒时间/结束日期
@property(nonatomic,strong) NSDate* setDate;

@property(nonatomic,assign)BOOL isAM;
@property(nonatomic,assign)NSInteger hour;
@property(nonatomic,assign)NSInteger minitue;


//重复
@property(nonatomic,strong)NSArray * frequenceArr;
@property(nonatomic,assign)NSInteger setRepeatCount;
@property(nonatomic,strong)NSArray * reciptCircleUnitArr;
@property(nonatomic,assign) TimeSetRepeatCircle setRepeatCircle;//天周月





@end
