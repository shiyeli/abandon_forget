//
//  XYHourMinuteCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYHourMinuteCell.h"

@implementation XYHourMinuteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCustomView];
    }
    return self;
}

-(void)setCustomView{
    _houtMinLab=[[UILabel alloc]init];
    _houtMinLab.textColor=[UIColor whiteColor];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"3:40 PM"];
    [attributedString setAttributes:@{NSFontAttributeName: SYSTEMFONT(45)} range:NSMakeRange(0, 4)];
    [attributedString setAttributes:@{NSFontAttributeName : SYSTEMFONT(20), NSBaselineOffsetAttributeName : @20} range:NSMakeRange(5, 2)];
    _houtMinLab.attributedText=attributedString;
    _houtMinLab.textAlignment=NSTextAlignmentCenter;
    [self.titleView addSubview:_houtMinLab];
    [_houtMinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.titleView);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
