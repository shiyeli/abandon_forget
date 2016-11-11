//
//  XYTimeSectionModel.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/11.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentModel.h"
#import "XYTimeCellModel.h"
@interface XYTimeSectionModel : XYParentModel

@property(nonatomic,copy)NSString* sectionTitle;

@property(nonatomic,assign)BOOL switchIsOpen;
@property(nonatomic,weak)UISwitch* mySwitch;

@property(nonatomic,strong)NSMutableArray <XYTimeCellModel*> * arrM;

@end
