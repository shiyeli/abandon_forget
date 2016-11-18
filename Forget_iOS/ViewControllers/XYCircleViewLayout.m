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

- (instancetype)initWithRadius:(CGFloat)radius aliginType:(WheelAlignmentType)alignType cellSize:(CGSize)cellSize spacing:(CGFloat)spacing{
    self = [super init];
    if (self) {
        
        self.radius=radius;
        self.alignType=alignType;
        self.cellSize=cellSize;
        self.spacing=spacing;

        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];

    self.itemCount=[self.collectionView numberOfItemsInSection:0];
    self.itemHeight=self.cellSize.height+self.spacing;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    [self.attrsArr removeAllObjects];
    
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

- (CGSize)collectionViewContentSize
{
    const CGSize theSize = {
        .width = self.collectionView.bounds.size.width,
        .height = (self.itemCount+1) * self.itemHeight,
    };
    return(theSize);
}

#pragma mark ---- 这个方法需要返回indexPath位置对应cell的布局属性
/**
 *  //TODO:  这个方法主要用于 切换布局的时候 如果不适用该方法 就不会切换布局的时候会报错
 *   reason: 'no UICollectionViewLayoutAttributes instance for -layoutAttributesForItemAtIndexPath: <NSIndexPath: 0xc000000000400016> {length = 2, path = 0 - 2}'
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //double newIndex = (indexPath.item + self.offset);
    
    //获取UICollectionViewLayoutAttributes
    //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
    UICollectionViewLayoutAttributes *theAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    theAttributes.size = self.cellSize;
    
    theAttributes.center=CGPointMake(self.collectionView.frame.size.width*0.5, (indexPath.row+1)* self.itemHeight);
    
//    float deltaX;//x轴方向的偏移
//    CGAffineTransform translationT;
//    CGAffineTransform rotationT = CGAffineTransformMakeRotation(10* newIndex *M_PI/180);
    
    if( self.alignType == WHEEL_ALIGNMEN_LEFT){
        
//        deltaX = self.cellSize.width/2;
//        theAttributes.center = CGPointMake(-self.deltaRadius + self.xOffset  , self.collectionView.bounds.size.height/2 + self.collectionView.contentOffset.y);
//        translationT =CGAffineTransformMakeTranslation(self.deltaRadius +self.deltaRadius, 0);
    }
    
//    theAttributes.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1,1), CGAffineTransformConcat(translationT, rotationT));
//    theAttributes.zIndex = indexPath.item;
    
    
    return theAttributes;
    
}





@end
