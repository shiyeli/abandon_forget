//
//  XYAddAddressViewController.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentViewController.h"
@class XYAddAddressViewController;


@protocol XYAddAddressViewControllerDelegate <NSObject>

@required
-(void)getNewSearchAddress:(XYAddAddressViewController*)currentCtl content:(XYAMapTip*)tip;

@end

@interface XYAddAddressViewController : XYParentViewController

@property(nonatomic,weak)id<XYAddAddressViewControllerDelegate> delegate;

@end
