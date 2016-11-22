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

-(UILabel*)name{
    if (!_name) {
        _name=[[UILabel alloc]init];
        _name.font=SYSTEMFONT(13);
        _name.textColor=[UIColor whiteColor];
        [self.contentView addSubview:_name];
    }
    

    return _name;
}

-(void)setModel:(XYAnimationViewModel *)model{
    _model=model;

    [self.imgView setImage:[UIImage imageNamed:_model.img]];
    self.name.text=_model.name;
    
   if (_model.isNameLeft) {
       _name.frame=CGRectMake(70, 0,100, 70);
       _name.textAlignment=NSTextAlignmentLeft;
   }else{
       _name.frame=CGRectMake(-100, 0,100, 70);
       _name.textAlignment=NSTextAlignmentRight;
    }
    
}

@end
