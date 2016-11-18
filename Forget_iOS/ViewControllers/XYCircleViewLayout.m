//
//  XYCircleViewLayout.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/17.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYCircleViewLayout.h"

@interface XYCircleViewLayout()


@property(nonatomic,strong)NSMutableArray* attrsArr;


@end


@implementation XYCircleViewLayout

-(NSMutableArray *)attrsArr
{
    if(!_attrsArr){
        _attrsArr=[[NSMutableArray alloc] init];
    }
    return _attrsArr;
}
/*
 
 @property (readwrite, nonatomic, assign) int itemCount;
 @property (readwrite, nonatomic, assign) WheelAlignmentType wheelType;
 @property (readwrite, nonatomic, assign) CGPoint center;
 @property (readwrite, nonatomic, assign) CGFloat offset;
 @property (readwrite, nonatomic, assign) CGFloat itemHeight;
 @property (readwrite, nonatomic, assign) CGFloat xOffset;
 @property (readwrite, nonatomic, assign) CGSize cellSize;
 @property (readwrite, nonatomic, assign) CGFloat spacing;
 @property (readwrite, nonatomic, assign) CGFloat radius;
 @property (readonly, nonatomic, strong) NSIndexPath *currentIndexPath;
 */
- (instancetype)initWithRadius:(CGFloat)radius aliginType:(WheelAlignmentType)alignType cellSize:(CGSize)cellSize xOffset:(CGFloat)xOffset spacing:(CGFloat)spacing
{
    self = [super init];
    if (self) {
        
        self.radius=radius;
        self.alignType=alignType;
        self.cellSize=cellSize;
        self.xOffset=xOffset;
        self.spacing=spacing;
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];

    [super prepareLayout];
    
    
    

}




-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self.attrsArr removeAllObjects];
    //计算出每组有多少个
    self.itemCount=[self.collectionView numberOfItemsInSection:0];
    //创建attributes
    for (int i=0; i<self.itemCount; i++) {
        //创建UICollectionViewLayoutAttributes
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
        UICollectionViewLayoutAttributes * attrs=[self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArr addObject:attrs];
    }
    return self.attrsArr;
}

#pragma mark ---- 这个方法需要返回indexPath位置对应cell的布局属性
/**
 *  //TODO:  这个方法主要用于 切换布局的时候 如果不适用该方法 就不会切换布局的时候会报错
 *   reason: 'no UICollectionViewLayoutAttributes instance for -layoutAttributesForItemAtIndexPath: <NSIndexPath: 0xc000000000400016> {length = 2, path = 0 - 2}'
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO: 主要是返回每个indexPath的attrs
    
    //创建UICollectionViewLayoutAttributes
    //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
    //计算出每组有多少个
    NSInteger  count=[self.collectionView numberOfItemsInSection:0];
    //角度
    CGFloat angle = 2* M_PI /count *indexPath.item;
    //设置半径
    CGFloat radius=100;
    //CollectionView的圆心的位置
    CGFloat Ox = self.collectionView.frame.size.width/2;
    CGFloat Oy = self.collectionView.frame.size.height/2;
    UICollectionViewLayoutAttributes * attrs=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.center =  CGPointMake(Ox+radius*sin(angle), Oy+radius*cos(angle));
    if (count==1) {
        attrs.size=CGSizeMake(200, 200);
    }else{
        attrs.size=CGSizeMake(50, 50);
    }
    return attrs;
}









//设置内容区域的大小
-(CGSize)collectionViewContentSize{
    const CGSize theSize = {
        .width = self.collectionView.bounds.size.width,
        .height = (self.itemCount-1) * self.itemHeight + self.collectionView.bounds.size.height,
    };
    return(theSize);
}


@end
