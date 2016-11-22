//
//  XYTimeParentCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentTableViewCell.h"
#import "XYTimeCellModel.h"

#define TIMECELL_COLOR_CYAN [XYTool stringToColor:@"#00BCD4"]
#define TIMECELL_COLOR_BLUE [XYTool stringToColor:@"#03A9F4"]
#define TIMECELL_COLOR_YELLOW [XYTool stringToColor:@"#FF9800"]


@interface XYTimeParentCell : XYParentTableViewCell

@property(nonatomic,strong)UIView* titleView;
@property(nonatomic,strong)UIView* centerView;
@property(nonatomic,strong)UIButton* closeBtn;
@property(nonatomic,strong)UIButton* sureBtn;

@property(nonatomic,strong)UIColor * cellColor;

@property(nonatomic,weak)XYTimeCellModel * model;



-(void)sureOrNot:(UIButton* )sender;

@end
