//
//  XYYearMonthDayCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeParentCell.h"
#import "FyCalendarView.h"

typedef BOOL (^SendBOOLBack)(id sender);

@interface XYYearMonthDayCell : XYTimeParentCell<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,assign)BOOL isSetNotifyTime;

@property(nonatomic,strong)UIButton* yearLab;
@property(nonatomic,strong)UIButton* monthDayLab;

@property(nonatomic,strong)FyCalendarView* calendarView;

@property(nonatomic,strong)UIPickerView* yearPicker;

@property(nonatomic,copy)SendBOOLBack sendBOOLBack;

@end
