//
//  XYTimeParentCell.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/8.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYTimeParentCell.h"


@implementation XYTimeParentCell
{
    UIView * _holdView;
    UIButton* _spreadOutBtn;
    UIView* _spreadOutView;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    
    
    
    _holdView=[[UIView alloc]init];
    [self.contentView addSubview:_holdView];
    [_holdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, DISTANCE_TO_EDGE,DISTANCE_TO_EDGE*2, DISTANCE_TO_EDGE));
    }];
    
    
    _holdView.layer.shadowOpacity=0.4f;
    _holdView.layer.shadowOffset=CGSizeMake(0, 0);
    _holdView.layer.shadowRadius=2.0f;
    _holdView.layer.shadowColor=[UIColor blackColor].CGColor;
    _holdView.layer.cornerRadius=5;
    _holdView.backgroundColor=[UIColor whiteColor];
    
    self.titleView=[[UIView alloc]init];
//   _titleView.backgroundColor=THIEM_COLOR;
    [_holdView addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_holdView);
        make.leading.equalTo(_holdView);
        make.trailing.equalTo(_holdView);
        make.height.equalTo(@(TIME_CELL_HEIGHT));
    }];
    
    _spreadOutBtn =[[UIButton alloc]init];
    [_spreadOutBtn setImage:[UIImage imageNamed:@"down_view_btn"] forState:UIControlStateNormal];
    [_spreadOutBtn addTarget:self action:@selector(spreadOutCell:) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:_spreadOutBtn];
    [_spreadOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleView);
        make.trailing.equalTo(_titleView).with.offset(-DISTANCE_TO_EDGE);
    }];
    
    
    
    
    _spreadOutView=[[UIView alloc]init];
    [_holdView addSubview:_spreadOutView];
    [_spreadOutView setFrame:CGRectMake(0, TIME_CELL_HEIGHT, Main_Screen_Width-DISTANCE_TO_EDGE*2, Main_Screen_Width-DISTANCE_TO_EDGE*2+40)];
    
    _centerView=[[UIView alloc]init];
    [_spreadOutView addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spreadOutView);
        make.leading.equalTo(_spreadOutView);
        make.trailing.equalTo(_spreadOutView);
        make.height.equalTo(_spreadOutView.mas_width);
    }];
    
    
    _sureBtn=[[UIButton alloc]init];
    [_sureBtn setImage:[UIImage imageNamed:@"sure_selection"] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureOrNot:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.tag=2;
    [_spreadOutView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom);
        make.trailing.equalTo(_spreadOutView).with.offset(-DISTANCE_TO_EDGE);
        make.width.equalTo(@60);
    }];
    _closeBtn=[[UIButton alloc]init];
    [_closeBtn setImage:[UIImage imageNamed:@"close_spreadout"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(sureOrNot:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.tag=1;
    [_spreadOutView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom);
        make.trailing.equalTo(_sureBtn.mas_leading).with.offset(-DISTANCE_TO_EDGE*3);
        make.width.equalTo(@60);
    }];
    
    //[_spreadOutView setHidden:YES];
}

-(void)setCellColor:(UIColor *)cellColor{
    _cellColor=cellColor;
    _titleView.backgroundColor=cellColor;

}

//点击取消或确认
-(void)sureOrNot:(UIButton* )sender{
   
    [self spreadOutView:NO];
    
    if (sender.tag==1) {//关闭
        
        
    }else{//确认
        
    }

    [XYTool transitionAnimationWhater];
}
//点击展开视图
-(void)spreadOutCell:(UIButton* )sender{
    [self spreadOutView:YES];
}
-(void)spreadOutView:(BOOL)spreadout{
    
    _model.isSpreadOut=spreadout;
    
    if (self.sendBlock) {
        self.sendBlock(_model);
    }
}

-(void)setModel:(XYTimeCellModel *)model{
    _model=model;
    [self setHidden:!_model.isSwitchOn];
    if (_model.isSwitchOn) {
        [_spreadOutView setHidden:!_model.isSpreadOut];
        [_spreadOutBtn setHidden:_model.isSpreadOut];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
