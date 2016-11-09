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
    UIButton* _closeBtn;
    UIButton* _sureBtn;
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
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, DISTANCE_TO_EDGE,0 , DISTANCE_TO_EDGE));
    }];
    _holdView.backgroundColor=[UIColor greenColor];
    _titleView=[[UIView alloc]init];
    _titleView.backgroundColor=THIEM_COLOR;
    [_holdView addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_holdView);
        make.leading.equalTo(_holdView);
        make.trailing.equalTo(_holdView);
        make.height.equalTo(@TIME_CELL_HEIGHT);
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
    _spreadOutView.backgroundColor=[UIColor blueColor];
    [_holdView addSubview:_spreadOutView];
    [_spreadOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView.mas_bottom);
        make.leading.equalTo(_holdView);
        make.trailing.equalTo(_holdView);
    }];
    
    _centerView=[[UIView alloc]init];
    _centerView.backgroundColor=[UIColor redColor];
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
    }];
    
    
    _closeBtn=[[UIButton alloc]init];
    [_closeBtn setImage:[UIImage imageNamed:@"close_spreadout"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(sureOrNot:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.tag=1;
    [_spreadOutView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_centerView.mas_bottom);
        make.trailing.equalTo(_sureBtn.mas_leading).with.offset(-DISTANCE_TO_EDGE*3);
    }];
    
    [_spreadOutView setHidden:YES];
}
//点击取消或确认
-(void)sureOrNot:(UIButton* )sender{
     [self spreadOutView:NO];
    
    if (sender.tag==1) {//关闭
        
        
    }else{//确认
    
    }

}
//点击展开视图
-(void)spreadOutCell:(UIButton* )sender{
    [self spreadOutView:YES];
}
-(void)spreadOutView:(BOOL)spreadout{
    
    if (spreadout) {
        CGFloat cellH=CGRectGetMaxY(_closeBtn.frame);
        _model.cellH=cellH+_titleView.frame.size.height+DISTANCE_TO_EDGE;
        [_spreadOutView setHidden:NO];
        
        [_spreadOutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.leading.equalTo(_holdView);
            make.trailing.equalTo(_holdView);
            make.bottom.equalTo(_holdView);
        }];
        
    }else{
        _model.cellH=TIME_CELL_HEIGHT;
        [_spreadOutView setHidden:YES];
        [_spreadOutView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleView.mas_bottom);
            make.leading.equalTo(_holdView);
            make.trailing.equalTo(_holdView);
            make.height.equalTo(@0);
        }];
    }
    _model.isSpreadOut=spreadout;
    [self setModel:_model];
}

-(void)setModel:(XYTimeCellModel *)model{
    _model=model;
    
    [self setHidden:!_model.isSwithOn];
    if (!_model.isSwithOn) {
        _model.isSpreadOut=NO;
    }
    
    [_spreadOutView setHidden:!_model.isSpreadOut];
    if (self.sendBlock) {
        self.sendBlock(_model);
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
