//
//  XYIsRepeatCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeParentCell.h"

@interface XYIsRepeatCell : XYTimeParentCell<UIPickerViewDelegate,UIPickerViewDataSource>

//key: count/circle
@property(nonatomic,strong)NSMutableDictionary* dic;

@property(nonatomic,strong)UILabel* repeatLab;
@property(nonatomic,strong)UIPickerView* myPickerView;

@end
