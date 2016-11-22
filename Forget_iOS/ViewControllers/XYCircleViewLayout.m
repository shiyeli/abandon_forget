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
        .height = (self.itemCount-1) * self.itemHeight,
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
    
    CGFloat viewOffsetY=self.collectionView.contentOffset.y;
    CGPoint relativeCenter=CGPointMake(self.circleCenter.x, viewOffsetY+self.collectionView.frame.size.height*0.5);
    
    
    //默认 item 在上面一排
    CGFloat itemX=relativeCenter.x+self.itemHeight*indexPath.row-viewOffsetY;
    CGFloat itemY=relativeCenter.y-self.radius;
    
    
    
    
    NSLog(@"%d itemX:  =====%f",indexPath.row, itemX);
    NSLog(@"%d itemY:  =====%f",indexPath.row, itemY);
    
    
    //半圆上的item与y轴负方向的夹角,(0,180)
    CGFloat angel;
    if (itemX>self.circleCenter.x) {
        angel=(itemX-self.circleCenter.x)/self.radius;
        if (angel<M_PI*2) {
            itemX=relativeCenter.x+sin(angel)*self.radius;
            itemY=relativeCenter.y-cos(angel)*self.radius;
        }else{
            theAttributes.size=CGSizeZero;
        }
    }
    
    
    
    
    
    
   //
    
    
    
    
    theAttributes.center=CGPointMake(itemX, itemY);
    theAttributes.zIndex=1000-indexPath.row;
   // theAttributes.center = CGPointMake(self.circleCenter.x+cos(angel)*self.radius ,self.circleCenter.y+sin(angel)*self.radius);
    

    NSLog(@"contentOffset.y: %lf",self.collectionView.contentOffset.y);
    
    
    
    return theAttributes;
    
#if 0
    
    double newIndex = (indexPath.item + 0);
    
    UICollectionViewLayoutAttributes *theAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    theAttributes.size = self.cellSize;
    
    float deltaX;
    CGAffineTransform translationT;
    CGAffineTransform rotationT = CGAffineTransformMakeRotation(self.spacing* newIndex *M_PI/180);
    if(indexPath.item == 3){
        NSLog(@"angle 3 :%f", self.spacing* newIndex);
    }
    
    
    deltaX = self.cellSize.width/2;
    theAttributes.center = CGPointMake(0 , self.collectionView.bounds.size.height/2 + self.collectionView.contentOffset.y);
    translationT =CGAffineTransformMakeTranslation(self.radius + (deltaX*1) , 0);
    
    
    
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1, 1);
    //theAttributes.alpha = scaleFactor;
    
    /*
     if( fabs(self.AngularSpacing* newIndex) > 90 ){
     theAttributes.hidden = YES;
     }else{
     theAttributes.hidden = NO;
     }
     */
    
    theAttributes.transform = CGAffineTransformConcat(scaleT, CGAffineTransformConcat(translationT, rotationT));
    theAttributes.zIndex = indexPath.item;
    
    return(theAttributes);
#endif
    
    
}





@end
