//
//  XYTimeParentCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentTableViewCell.h"
#import "XYTimeCellModel.h"
@interface XYTimeParentCell : XYParentTableViewCell

@property(nonatomic,strong)UIView* titleView;

@property(nonatomic,weak)XYTimeCellModel * model;





@end
