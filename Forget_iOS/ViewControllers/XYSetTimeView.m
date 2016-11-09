//
//  XYSetTimeView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetTimeView.h"
//组头高度
#define SECTION_HEADER_HEIGHT 44.0
#import "XYYearMonthDayCell.h"
#import "XYIsRepeatCell.h"
#import "XYHourMinuteCell.h"
#import "XYTimeCellModel.h"



@interface XYSetTimeView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArr;



@end

@implementation XYSetTimeView




-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    self.dataArr=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        NSMutableArray* sectionArr=[NSMutableArray array];
        if (i==0) {
            for (int j=0; j<2; j++) {
                XYTimeCellModel* model=[[XYTimeCellModel alloc]init];
                model.isSwithOn=YES;
                model.isSpreadOut=NO;
                [sectionArr addObject:model];
            }
        }else{
            XYTimeCellModel* model=[[XYTimeCellModel alloc]init];
            model.isSwithOn=YES;
            model.isSpreadOut=NO;
            [sectionArr addObject:model];
        }
        [self.dataArr addObject:sectionArr];
    }
    
}

-(XYTimeParentCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeParentCell* cell=[[XYTimeParentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    XYTimeCellModel* model=[self.dataArr[indexPath.section]objectAtIndex:indexPath.row];
    model.indexPath=indexPath;
    cell.model=model;
    __weak XYSetTimeView* weakSelf=self;
    cell.sendBlock=^(XYTimeCellModel*  model){
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[model.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            
            
            
        }else{
        
            
            
        
        }
    }else if (indexPath.section==1){
    
        if (indexPath.row==0) {
            
            
            
            
            
            
            
        }
    }else if (indexPath.section==2){
    
        if (indexPath.row==0) {
            
            
            
            
            
        }
    }
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeCellModel* model=[self.dataArr[indexPath.section] objectAtIndex:indexPath.row];
    return model.cellH;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section==0) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    XYTimeCellModel* model=[self.dataArr[section] objectAtIndex:0];
    
    
    
    UIView* header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, SECTION_HEADER_HEIGHT)];
    
    UISwitch* mySwitch=[[UISwitch alloc]init];
    mySwitch.onTintColor=THIEM_COLOR;
    mySwitch.tag=section;
    [mySwitch setOn:model.isSwithOn];
    [mySwitch addTarget:self action:@selector(switchActions:) forControlEvents:UIControlEventValueChanged];
    [header addSubview:mySwitch];
    [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(header).with.offset(DISTANCE_TO_EDGE);
        make.centerY.equalTo(header);
    }];
    
    UILabel* myLab=[[UILabel alloc]init];
    if (section==0) {
        myLab.text=@"提醒时间";
    }else if (section==1){
        myLab.text=@"重复";
    }else if (section==2){
        myLab.text=@"结束提醒日期";
    }
    [header addSubview:myLab];
    [myLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.leading.equalTo(mySwitch.mas_trailing).with.offset(10);
    }];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEADER_HEIGHT;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(void)switchActions:(UISwitch*)sender{
    NSMutableArray* arrM=[NSMutableArray arrayWithArray:[self.dataArr objectAtIndex:sender.tag]];
    
    for (XYTimeCellModel* modle in arrM) {
        modle.isSwithOn=sender.isOn;
    }
    
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag] withRowAnimation:UITableViewRowAnimationFade];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
