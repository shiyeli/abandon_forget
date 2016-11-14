//
//  XYYearMonthDayCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeParentCell.h"
#import "FyCalendarView.h"
@interface XYYearMonthDayCell : XYTimeParentCell

@property(nonatomic,strong)UILabel* yearLab;
@property(nonatomic,strong)UILabel* monthDayLab;

@property(nonatomic,strong)FyCalendarView* calendarView;

@end
