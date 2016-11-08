//
//  XYParentTableViewCell.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SendViewBlock)(id sender);

@interface XYParentTableViewCell : UITableViewCell

@property (nonatomic,copy)SendViewBlock sendBlock;
@end
