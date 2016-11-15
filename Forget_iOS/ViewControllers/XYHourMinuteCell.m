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
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"3:40 PM"];
//    [attributedString setAttributes:@{NSFontAttributeName: SYSTEMFONT(45)} range:NSMakeRange(0, 4)];
//    [attributedString setAttributes:@{NSFontAttributeName : SYSTEMFONT(20), NSBaselineOffsetAttributeName : @20} range:NSMakeRange(5, 2)];
//    _houtMinLab.attributedText=attributedString;
    _houtMinLab.textAlignment=NSTextAlignmentCenter;
    _houtMinLab.font=SYSTEMFONT(45);
    
    [self.titleView addSubview:_houtMinLab];
    [_houtMinLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.leading.equalTo(self.titleView).with.offset(Main_Screen_Width*0.25);
    }];
    
    
    
    _clockView=[[ALDClock alloc]initWithFrame:CGRectMake(DISTANCE_TO_EDGE, DISTANCE_TO_EDGE, Main_Screen_Width-DISTANCE_TO_EDGE*4, Main_Screen_Width-DISTANCE_TO_EDGE*4)];
    [self.centerView addSubview:_clockView];
    [self applyClockCustomisations];
}
- (void)applyClockCustomisations
{
    // Change the background color of the clock (note that this is the color
    // of the clock face)
    self.clockView.backgroundColor =[XYTool stringToColor:@"#F5F5F5"];
    
    // Add a title and subtitle to the clock face
    self.clockView.title = @"";
    self.clockView.subtitle = @"";
    
    // When the time changes, call the the clockDidChangeTime: method.
    [self.clockView addTarget:self action:@selector(clockDidChangeTime:) forControlEvents:UIControlEventValueChanged];
    
    // When the user begins/ends manually changing the time, call these methods.
    [self.clockView addTarget:self action:@selector(clockDidBeginDragging:) forControlEvents:UIControlEventTouchDragEnter];
    [self.clockView addTarget:self action:@selector(clockDidEndDragging:) forControlEvents:UIControlEventTouchDragExit];
    
    // Set the initial time
    [self.clockView setHour:13 minute:51 animated:NO];
    
    // Change the clock's border color and width
    self.clockView.borderColor = THIEM_COLOR;
    self.clockView.borderWidth = 0.0f;
}

#pragma mark - Clock Callback Methods

- (void)clockDidChangeTime:(ALDClock *)clock
{
    NSLog(@"The time is: %02d:%02d", clock.hour, clock.minute);
    _houtMinLab.text=[NSString stringWithFormat:@"%02d:%02d",clock.hour,clock.minute];
}

- (void)clockDidBeginDragging:(ALDClock *)clock
{
    clock.borderColor = [UIColor colorWithRed:0.78 green:0.22 blue:0.22 alpha:1.0];
}

- (void)clockDidEndDragging:(ALDClock *)clock
{
    clock.borderColor = [UIColor colorWithRed:0.22 green:0.78 blue:0.22 alpha:1.0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
