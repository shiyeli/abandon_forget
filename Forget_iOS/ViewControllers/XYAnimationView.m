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
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        commonArr=@[@{@"img":@"restaurant_btn",@"name":@"餐饮"},
                       @{@"img":@"supermarket_btn",@"name":@"超市"},
                       @{@"img":@"hospital_btn",@"name":@"医院"},
                       @{@"img":@"park_btn",@"name":@"停车场"},
                    @{@"img":@"bank_btn",@"name":@"银行"},
                    
                    @{@"img":@"hospital_btn",@"name":@"菜市场"},
                    @{@"img":@"park_btn",@"name":@"快时代"},
                    @{@"img":@"bank_btn",@"name":@"梦思特"},
                    @{@"img":@"girl_home",@"name":@"女朋友家"},
                    @{@"img":@"parents_home",@"name":@"父母家"},
                    @{@"img":@"parents_home",@"name":@"第六个"}];
        
        personArr=@[@{@"img":@"home_btn",@"name":@"家"},
                       @{@"img":@"company_btn",@"name":@"公司"},
                       @{@"img":@"exercise_btn",@"name":@"健身房"},
                       @{@"img":@"girl_home",@"name":@"女朋友家"},
                       @{@"img":@"parents_home",@"name":@"父母家"},
                       @{@"img":@"parents_home",@"name":@"第六个"}];
        
       XYCircleViewLayout* layout=[[XYCircleViewLayout alloc]initWithRadius:Main_Screen_Width*0.3 aliginType:WHEEL_ALIGNMEN_LEFT cellSize:CGSizeMake(70, 70) spacing:20];
        
        self.myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor=[UIColor clearColor];
        [self addSubview:self.myCollectionView];
        cellId=@"cellIdentifier";
        [self.myCollectionView registerClass:[XYCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        self.myCollectionView.delegate=self;
        self.myCollectionView.dataSource=self;
        
    }
    return self;
}

-(void)setIsCommomAddress:(BOOL)isCommomAddress{
    _isCommomAddress=isCommomAddress;
    
    self.dataArray=[NSMutableArray array];
    for (NSDictionary* dic in (isCommomAddress?commonArr:personArr)) {
        XYAnimationViewModel* model=[[XYAnimationViewModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
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
    
    if (indexPath.row==0) {
        cell.backgroundColor=[UIColor redColor];
    }else{
        cell.backgroundColor=[UIColor grayColor];
    }
    cell.model=model;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //XYCollectionViewCell *cell = (XYCollectionViewCell *)[self.myCollectionView cellForItemAtIndexPath:indexPath];
    
     [self removeFromSuperview];
    
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
