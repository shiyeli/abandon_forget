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
#import "XYTimeSectionModel.h"


@interface XYSetTimeView ()<UITableViewDelegate,UITableViewDataSource>

{
    XYYearMonthDayCell* yearCell_1;
    XYHourMinuteCell* hourMinCell;
    XYIsRepeatCell* repeatCell;
    XYYearMonthDayCell* yearCell_2;
}

@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation XYSetTimeView




-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    
    [self setModel];
    
    [self initCellUI];
}
-(void)initCellUI{
    yearCell_1=[[XYYearMonthDayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    hourMinCell=[[XYHourMinuteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    repeatCell=[[XYIsRepeatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    yearCell_2=[[XYYearMonthDayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

}
-(void)setModel{
    self.dataArr=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        XYTimeSectionModel* sectionM=[[XYTimeSectionModel alloc]init];
        sectionM.switchIsOpen=YES;
        
        XYTimeCellModel* cellM=[[XYTimeCellModel alloc]init];
        cellM.isSwitchOn=sectionM.switchIsOpen;
        cellM.isSpreadOut=NO;
        [sectionM.arrM addObject:cellM];
        if (i==0) {
            sectionM.sectionTitle=@"提醒时间";
            
            //第一组有两个cell
            XYTimeCellModel* cellM=[[XYTimeCellModel alloc]init];
            cellM.isSwitchOn=sectionM.switchIsOpen;
            cellM.isSpreadOut=NO;
            [sectionM.arrM addObject:cellM];
            
            
        }else if (i==1){
            sectionM.sectionTitle=@"重复";
            
        }else if (i==2){
            sectionM.sectionTitle=@"结束重复日期";
            
            
        }
        
        [self.dataArr addObject:sectionM];
    }
}

-(XYTimeParentCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeParentCell* cell=nil;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell=yearCell_1;
            
            
            
        }else{
            
            cell=hourMinCell;
            
            
        }
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            
            cell=repeatCell;

            
            
            
            
            
        }
    }else if (indexPath.section==2){
        
        if (indexPath.row==0) {
            
            cell=yearCell_2;

            
            
            
        }
    }
    
    XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:indexPath.section];
    
    XYTimeCellModel* cellModel=[sectionModel.arrM objectAtIndex:indexPath.row];
    cellModel.indexPath=indexPath;

    __weak XYSetTimeView* weakSelf=self;
    cell.sendBlock=^(XYTimeCellModel*  model){
        
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[model.indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    };
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=cellModel;
    
    
    NSLog(@"--------%@---------",cell);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:indexPath.section];
    
    XYTimeCellModel* model=[sectionModel.arrM objectAtIndex:indexPath.row];
    
    NSLog(@"+++++%f",model.cellH);
    
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
    
    XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:section];
    
    UIView* header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, SECTION_HEADER_HEIGHT)];
    
    UISwitch* mySwitch=[[UISwitch alloc]init];
    mySwitch.onTintColor=THIEM_COLOR;
    mySwitch.tag=section;
    [mySwitch setOn:sectionModel.switchIsOpen];
    [mySwitch addTarget:self action:@selector(switchActions:) forControlEvents:UIControlEventValueChanged];
    [header addSubview:mySwitch];
    [mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(header).with.offset(DISTANCE_TO_EDGE);
        make.centerY.equalTo(header);
    }];
    sectionModel.mySwitch=mySwitch;
    
    UILabel* myLab=[[UILabel alloc]init];
    myLab.text=sectionModel.sectionTitle;
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
    
    for (int i=sender.tag; i<self.dataArr.count; i++) {
        XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:i];
        sectionModel.switchIsOpen=sender.isOn;
        
        for (XYTimeCellModel* model in sectionModel.arrM) {
            model.isSwitchOn=sender.isOn;
        }
    }
    [self.myTableView reloadData];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
