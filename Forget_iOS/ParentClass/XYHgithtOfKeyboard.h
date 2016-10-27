//
//  XYHgithtOfKeyboard.h
//  Ticket
//
//  Created by 叶同学 on 16/7/13.
//  Copyright © 2016年 yexianyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XYHgithtOfKeyboardDelegate <NSObject>

-(void)heithtOfKeyboard:(CGFloat)height isShow:(BOOL)isShow;

@end

@interface XYHgithtOfKeyboard : NSObject

@property(nonatomic,weak)id<XYHgithtOfKeyboardDelegate> delegate;

@end
