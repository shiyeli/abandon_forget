//
//  XYHgithtOfKeyboard.m
//  Ticket
//
//  Created by 叶同学 on 16/7/13.
//  Copyright © 2016年 yexianyong. All rights reserved.
//

#import "XYHgithtOfKeyboard.h"

@implementation XYHgithtOfKeyboard

- (instancetype)init
{
    self = [super init];
    if (self) {
        //处理键盘遮挡输入框
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark - 处理输入框被弹起键盘遮挡问题

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardChange:(NSNotification*)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    if (notification.name == UIKeyboardWillShowNotification) {//键盘弹起
        //获取最下面输入框的位置
        
        [self.delegate heithtOfKeyboard:keyboardEndFrame.size.height isShow:YES];
    }else{//键盘隐藏
        
        [self.delegate heithtOfKeyboard:0 isShow:NO];
        
    }
    
    [UIView commitAnimations];
}

@end
