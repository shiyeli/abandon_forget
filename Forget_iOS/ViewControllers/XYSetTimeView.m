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
@property(nonatomic,strong)XYYearMonthDayCell* yearCell_1;
@property(nonatomic,strong)XYHourMinuteCell* hourMinCell;
@property(nonatomic,strong)XYIsRepeatCell* repeatCell;
@property(nonatomic,strong)XYYearMonthDayCell* yearCell_2;

@property(nonatomic,strong)NSMutableArray * dataArr;

@end

@implementation XYSetTimeView

-(void)setModel:(XYNotifyModel *)model{
    _model=model;
    
    [self setModelData:_model];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor whiteColor];
    self.myTableView.sectionFooterHeight=0.0f;
    
    [self initCellUI];
}

-(NSDate*)mergeYearMonty:(XYTimeCellModel*)yearModel day:(XYTimeCellModel*)dayModel{
    self.model.isAM=dayModel.isAM;
    self.model.hour=dayModel.hour;
    self.model.minitue=dayModel.minitue;
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:yearModel.setDate];
    
    comp.hour=dayModel.isAM?dayModel.hour:dayModel.hour+12;
    comp.minute=dayModel.minitue;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone: [NSTimeZone localTimeZone]];
    self.hourMinCell.model.setDate=[calendar dateFromComponents:comp];
    return [calendar dateFromComponents:comp];
}

-(void)initCellUI{
    WS(weakSelf)
    _yearCell_1=[[XYYearMonthDayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _yearCell_1.isSetNotifyTime=YES;
    _yearCell_1.sendBlock=^(XYTimeCellModel* model){
        
        weakSelf.model.notifyTime=[weakSelf mergeYearMonty:model day:weakSelf.hourMinCell.model];
        [weakSelf.myTableView reloadData];
        NSLog(@"提醒年月日:%@",[NSString stringWithFormat:@"%@",weakSelf.model.notifyTime]);
    };
    _hourMinCell=[[XYHourMinuteCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _hourMinCell.sendBlock=^(XYTimeCellModel* model){
        
        weakSelf.model.notifyTime=[weakSelf mergeYearMonty:weakSelf.yearCell_1.model day:model];
        [weakSelf.myTableView reloadData];
        NSLog(@"提醒时分:%@",[NSString stringWithFormat:@"%@",weakSelf.model.notifyTime]);
        
    };
    _repeatCell=[[XYIsRepeatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _repeatCell.sendBlock=^(XYTimeCellModel* model){
        weakSelf.model.frequency=model.setRepeatCount;
        weakSelf.model.repeatUnit=model.setRepeatCircle;
        [weakSelf.myTableView reloadData];
        NSLog(@"重复:%d %d",model.setRepeatCount,model.setRepeatCircle);
    };
    _yearCell_2=[[XYYearMonthDayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    _yearCell_2.isSetNotifyTime=NO;
    _yearCell_2.sendBlock=^(XYTimeCellModel* model){
        weakSelf.model.closingDate=model.setDate;
        [weakSelf.myTableView reloadData];
        NSLog(@"结束提醒时间:%@",[NSString stringWithFormat:@"%@",weakSelf.model.closingDate]);
    };
    _yearCell_2.sendBOOLBack=^(XYTimeCellModel* model){
        
        if ([XYTool compareDate:NO OneDay:model.setDate withAnotherDay:weakSelf.model.notifyTime]==1) {
            weakSelf.model.closingDate=model.setDate;
            [weakSelf.myTableView reloadData];
            return YES;
        }else {
            return NO;
        }
    };
    
    
}
-(void)setModelData:(XYNotifyModel*)model{
    
    self.dataArr=[NSMutableArray array];
    for (int i=0; i<3; i++) {
        XYTimeSectionModel* sectionM=[[XYTimeSectionModel alloc]init];
        
        
        
        
        if (i==0) {
            sectionM.switchIsOpen=model.haveSetTime;
            sectionM.sectionTitle=@"提醒时间";
            
            
            XYTimeCellModel* cellM=[[XYTimeCellModel alloc]init];
            cellM.isSwitchOn=sectionM.switchIsOpen;
            cellM.isSpreadOut=NO;
            cellM.setDate=model.notifyTime;
            [sectionM.arrM addObject:cellM];
            
            
            //第一组有两个cell
            XYTimeCellModel* cellM2=[[XYTimeCellModel alloc]init];
            cellM2.isSwitchOn=sectionM.switchIsOpen;
            cellM2.isSpreadOut=NO;
            cellM2.setDate=model.notifyTime;
            [sectionM.arrM addObject:cellM2];
            
            
        }else if (i==1){
            sectionM.switchIsOpen=model.haveSetRepeat;
            sectionM.sectionTitle=@"重复";
            
            XYTimeCellModel* cellM=[[XYTimeCellModel alloc]init];
            cellM.isSwitchOn=sectionM.switchIsOpen;
            cellM.isSpreadOut=NO;
            cellM.frequenceArr=model.frequencyArr;
            cellM.setRepeatCount=model.frequency;
            cellM.reciptCircleUnitArr=model.repeatUnitArr;
            cellM.setRepeatCircle=model.repeatUnit;
            [sectionM.arrM addObject:cellM];
            
        }else if (i==2){
            sectionM.switchIsOpen=model.haveSetClosingDate;
            sectionM.sectionTitle=@"结束重复日期";
            
            XYTimeCellModel* cellM=[[XYTimeCellModel alloc]init];
            cellM.isSwitchOn=sectionM.switchIsOpen;
            cellM.isSpreadOut=NO;
            cellM.setDate=model.closingDate;
            [sectionM.arrM addObject:cellM];
        }
        
        [self.dataArr addObject:sectionM];
    }
}

-(XYTimeParentCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeParentCell* cell=nil;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell=_yearCell_1;
            
            
            
        }else{
            
            cell=_hourMinCell;
            
            
        }
        cell.cellColor=TIMECELL_COLOR_CYAN;
        [cell.closeBtn setImage:[UIImage imageNamed:@"settime_cyan_close"] forState:UIControlStateNormal];
        [cell.sureBtn setImage:[UIImage imageNamed:@"settime_cyan_sure"] forState:UIControlStateNormal];
        
    }else if (indexPath.section==1){
        
        if (indexPath.row==0) {
            
            cell=_repeatCell;
            cell.cellColor=TIMECELL_COLOR_BLUE;
            [cell.closeBtn setImage:[UIImage imageNamed:@"settime_blue_close"] forState:UIControlStateNormal];
            [cell.sureBtn setImage:[UIImage imageNamed:@"settime_blue_sure"] forState:UIControlStateNormal];
            
            
            
            
        }
    }else if (indexPath.section==2){
        
        if (indexPath.row==0) {
            
            cell=_yearCell_2;
            cell.cellColor=TIMECELL_COLOR_YELLOW;
            [cell.closeBtn setImage:[UIImage imageNamed:@"settime_yellow_close"] forState:UIControlStateNormal];
            [cell.sureBtn setImage:[UIImage imageNamed:@"settime_yellow_sure"] forState:UIControlStateNormal];

            
        }
    }
    
    XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:indexPath.section];
    
    XYTimeCellModel* cellModel=[sectionModel.arrM objectAtIndex:indexPath.row];
    cellModel.indexPath=indexPath;

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=cellModel;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:indexPath.section];
    
    XYTimeCellModel* model=[sectionModel.arrM objectAtIndex:indexPath.row];
    
    
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
    header.backgroundColor=[UIColor whiteColor];
    
    sectionModel.mySwitch.tintColor=THIEM_COLOR;
     sectionModel.mySwitch.onTintColor=THIEM_COLOR;
     sectionModel.mySwitch.tag=kTag+section;
    [ sectionModel.mySwitch setOn:sectionModel.switchIsOpen];
    [ sectionModel.mySwitch addTarget:self action:@selector(switchActions:) forControlEvents:UIControlEventValueChanged];
    [header addSubview: sectionModel.mySwitch];
    [ sectionModel.mySwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(header).with.offset(DISTANCE_TO_EDGE);
        make.centerY.equalTo(header);
    }];
    
    
    UILabel* myLab=[[UILabel alloc]init];
    myLab.text=sectionModel.sectionTitle;
    [header addSubview:myLab];
    [myLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(header);
        make.leading.equalTo( sectionModel.mySwitch.mas_trailing).with.offset(10);
    }];
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SECTION_HEADER_HEIGHT;
}

-(void)switchActions:(UISwitch*)sender{
    
    for (int i=sender.tag-kTag; i<self.dataArr.count; i++) {
        XYTimeSectionModel* sectionModel=[self.dataArr objectAtIndex:i];
        sectionModel.switchIsOpen=sender.isOn;
        if (i>sender.tag-kTag) {
            [sectionModel.mySwitch setEnabled:sender.isOn];
        }
        for (XYTimeCellModel* model in sectionModel.arrM) {
            model.isSwitchOn=sender.isOn;
        }
        
        //修改Model
        if (i==0) {
            self.model.haveSetTime=sectionModel.switchIsOpen;
        
        }else if (i==1){
            self.model.haveSetRepeat=sectionModel.switchIsOpen;
        }else if (i==2){
            self.model.haveSetClosingDate=sectionModel.switchIsOpen;
        }
  
    }
    [self.myTableView reloadData];
    
    NSLog(@"haveSetTime:%d  haveSetRepeat:%d  haveSetClosingDate:%d",self.model.haveSetTime,self.model.haveSetRepeat,self.model.haveSetClosingDate);
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
