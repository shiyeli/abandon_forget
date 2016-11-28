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

@property(nonatomic,strong)UIButton* yearLab;
@property(nonatomic,strong)UIButton* monthDayLab;

@property(nonatomic,strong)FyCalendarView* calendarView;

@property(nonatomic,strong)UIPickerView* yearPicker;

@end
