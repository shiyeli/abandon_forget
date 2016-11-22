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
        self.itemHeight=self.cellSize.height+self.spacing;
        if (alignType==WHEEL_ALIGNMEN_LEFT) {
            self.circleCenter=CGPointMake(self.itemHeight*0.5,Main_Screen_Height*0.5);
        }else{
            self.circleCenter=CGPointMake(Main_Screen_Width-self.itemHeight*0.5,Main_Screen_Height*0.5);
        }
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];

    self.itemCount=[self.collectionView numberOfItemsInSection:0];
    
    
    
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
        .height =self.itemCount* self.itemHeight,
    };
    return(theSize);
}


-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    //获取UICollectionViewLayoutAttributes
    //这里需要 告诉 UICollectionViewLayoutAttributes 是哪里的attrs
    UICollectionViewLayoutAttributes *theAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    theAttributes.size = self.cellSize;
    
    CGFloat viewOffsetY=self.collectionView.contentOffset.y;
    
    CGPoint relativeCenter=CGPointMake(self.circleCenter.x, viewOffsetY+self.collectionView.frame.size.height*0.5);
    
    
    //计算item中心点
    CGPoint attriCenter=CGPointZero;
    
    if (self.alignType==WHEEL_ALIGNMEN_LEFT) {
        
        /*********** 靠左 ****************/
        
        //默认 item 在上面一排
        CGFloat itemX=relativeCenter.x+self.itemHeight*indexPath.row-viewOffsetY;
        CGFloat itemY=relativeCenter.y-self.radius;
        //半圆上的item与y轴负方向的夹角,(0,180)
        CGFloat angel;
        if (itemX>self.circleCenter.x) {
            angel=(itemX-self.circleCenter.x)/self.radius;
            if (angel<M_PI*2) {
                itemX=relativeCenter.x+sin(angel)*self.radius;
                itemY=relativeCenter.y-cos(angel)*self.radius;
            }else{
                itemX=relativeCenter.x+self.itemHeight*indexPath.row-viewOffsetY;
                itemY=relativeCenter.y+self.radius;
            
            }
        }
        attriCenter=CGPointMake(itemX, itemY);
        
    }else{
        
        /*********** 靠右 ****************/
        
        //默认 item 在上面一排
        CGFloat itemX=relativeCenter.x-self.itemHeight*indexPath.row+viewOffsetY;
        CGFloat itemY=relativeCenter.y-self.radius;
        //半圆上的item与y轴负方向的夹角,(0,180)
        CGFloat angel;
        if (itemX<self.circleCenter.x) {
            angel=(self.circleCenter.x-itemX)/self.radius;
            if (angel<M_PI*2) {
                itemX=relativeCenter.x-sin(angel)*self.radius;
                itemY=relativeCenter.y-cos(angel)*self.radius;
            }else{
                itemX=relativeCenter.x+self.itemHeight*indexPath.row-viewOffsetY;
                itemY=relativeCenter.y+self.radius;
            }
        }
        attriCenter=CGPointMake(itemX, itemY);
    }
    theAttributes.center=attriCenter;
    theAttributes.zIndex=self.itemCount-indexPath.row;
 
    return theAttributes;
}





@end
