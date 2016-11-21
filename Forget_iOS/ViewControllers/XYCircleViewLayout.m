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
    self.circleCenter=CGPointMake(self.itemHeight,self.collectionView.frame.size.height*0.5);
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

//初始化布局属性
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

//范围ContentSize
- (CGSize)collectionViewContentSize
{
    const CGSize theSize = {
        .width = self.collectionView.bounds.size.width,
        .height = (self.itemCount+1) * self.itemHeight+self.collectionView.frame.size.height,
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
    
    
    //获取UICollectionViewLayoutAttributes
    //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
    UICollectionViewLayoutAttributes *theAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    theAttributes.size = self.cellSize;
    
    
    //theAttributes.center = CGPointMake(self.circleCenter.x + _radius * cosf(2 * indexPath.item * M_PI / 7), self.circleCenter.y + _radius * sinf(2 * indexPath.item * M_PI / 7));
    
    theAttributes.center = CGPointMake(50 , self.collectionView.contentOffset.y );
    theAttributes.transform=CGAffineTransformMakeTranslation(self.radius + self.cellSize.width/2 , 0);

    NSLog(@"contentOffset.y: %lf",self.collectionView.contentOffset.y);
    
    return theAttributes;
    
}





@end
