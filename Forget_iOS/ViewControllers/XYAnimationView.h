//
//  XYAnimationView.h
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/16.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYParentView.h"
#import "XYAnimationViewModel.h"
@interface XYAnimationView : XYParentView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,assign)BOOL isCommomAddress;
@property(nonatomic,strong)NSMutableArray <XYAnimationViewModel*>* dataArray;


@property (strong, nonatomic)  UICollectionView *myCollectionView;



@end
