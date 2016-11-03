//
//  XYSetLoctionView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetLoctionView.h"


@interface XYSetLoctionView ()



@end

@implementation XYSetLoctionView

- (IBAction)clickEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //常见地点
        
        
        
        }
            break;
        case 2:{
            //个人地点
            
            
        }
            break;
        case 3:{
            //搜索
            if (self.sendBlock) {
                self.sendBlock(sender);
            }
            
        }
            break;
        case 4:{
            //关闭
            self.needSetting=NO;
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}



-(void)awakeFromNib{
    [super awakeFromNib];
    
    
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
