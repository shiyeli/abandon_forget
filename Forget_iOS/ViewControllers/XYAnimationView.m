//
//  XYAnimationView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/16.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAnimationView.h"
#import "XYCircleViewLayout.h"
#import "XYCollectionViewCell.h"

@implementation XYAnimationView
{
    NSArray* commonArr;
    NSArray* personArr;
    
    NSString* cellId;
    
    UIButton* closeBtn;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
       XYCircleViewLayout* layout=[[XYCircleViewLayout alloc]initWithRadius:Main_Screen_Width*0.4 aliginType:WHEEL_ALIGNMEN_LEFT cellSize:CGSizeMake(70, 70) spacing:Main_Screen_Width*0.1];
        
        self.myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) collectionViewLayout:layout];
        self.myCollectionView.showsVerticalScrollIndicator=NO;
        self.myCollectionView.backgroundColor=[UIColor clearColor];
        [self addSubview:self.myCollectionView];
        cellId=@"cellIdentifier";
        [self.myCollectionView registerClass:[XYCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        self.myCollectionView.delegate=self;
        self.myCollectionView.dataSource=self;
        
        
        closeBtn=[[UIButton alloc]init];
        [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setFrame:CGRectMake(0, 0, 87, 87)];
        [self addSubview:closeBtn];
        
        
    }
    return self;
}
-(void)closeAction{
    [self removeFromSuperview];
    [XYTool transitionAnimationWhater];
}
-(void)setIsCommomAddress:(BOOL)isCommomAddress{
    _isCommomAddress=isCommomAddress;
    
    [self.myCollectionView reloadData];
    
    XYCircleViewLayout* layout;
    if (_isCommomAddress) {
        layout=[[XYCircleViewLayout alloc]initWithRadius:Main_Screen_Width*0.4 aliginType:WHEEL_ALIGNMEN_LEFT cellSize:CGSizeMake(70,70) spacing:Main_Screen_Width*0.1];
        [closeBtn setImage:[UIImage imageNamed:@"close_common"] forState:UIControlStateNormal];
        
    }else{
        layout=[[XYCircleViewLayout alloc]initWithRadius:Main_Screen_Width*0.4 aliginType:WHEEL_ALIGNMEN_RIGHT cellSize:CGSizeMake(70, 70) spacing:Main_Screen_Width*0.1];
        [closeBtn setImage:[UIImage imageNamed:@"close_personal"] forState:UIControlStateNormal];
        
    }
    
    [self.myCollectionView setCollectionViewLayout:layout];
    [closeBtn setCenter:layout.circleCenter];
    
    [self.myCollectionView reloadData];
}



#pragma mark collectionView 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    XYAnimationViewModel* model=[self.dataArray objectAtIndex:indexPath.row];
    model.row=indexPath.row;
    cell.backgroundColor=[UIColor clearColor];
    cell.model=model;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYAnimationViewModel* model = [self.dataArray objectAtIndex:indexPath.row];
    
    if ([model.tip.remarkName isEqualToString:@"待收藏"]) {
        [XYTool showPromptView:@"地点不可用" holdView:nil];
        return;
    }
    
    if (self.sendBlock) {
        self.sendBlock(model);
    }
    
    [self closeAction];
}


//设置每个item的尺寸
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(70, 70);
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
