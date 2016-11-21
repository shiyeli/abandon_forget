//
//  XYCollectionViewCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/17.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYCollectionViewCell.h"

@interface XYCollectionViewCell()

@property(nonatomic,strong)UIImageView * imgView;

@property(nonatomic,strong)UILabel* name;

@end


@implementation XYCollectionViewCell

-(UIImageView*)imgView{
    if (!_imgView) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

-(void)setModel:(XYAnimationViewModel *)model{
    _model=model;
    [self.imgView setImage:[UIImage imageNamed:_model.img]];
}

@end
