//
//  XYSetLoctionView.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/11/3.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYSetLoctionView.h"
#import "XYAnimationView.h"
#import "XYLocationButton.h"
#import <AMapSearchKit/AMapSearchKit.h>
#define SEARCH_HISTORY_CELL_HEIGHT 44.0f
#define SEARCH_HISTORY_COUNT 4
#import "LBSQLManager.h"
#import "XYAMapTip.h"
@interface XYSetLoctionView ()<UITableViewDelegate,UITableViewDataSource>

{
    NSInteger tempSelectRow;
}

@property (weak, nonatomic) IBOutlet UISwitch *mySwith;

@property (weak, nonatomic) IBOutlet UIStackView *holdStackView;

@property (weak, nonatomic) IBOutlet XYLocationButton *commonBtn;
@property (weak, nonatomic) IBOutlet XYLocationButton *personBtn;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *myTableViewH;



@property (weak, nonatomic) IBOutlet UIButton *arriveAddressBtn;
@property (weak, nonatomic) IBOutlet UIButton *leaveAddressBtn;

@property(strong,nonatomic) XYAnimationView* animationView;

@property(strong,nonatomic)NSMutableArray* dataArray;

@end

@implementation XYSetLoctionView

-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(XYAnimationView*)animationView{
    if (!_animationView) {
        _animationView=[[XYAnimationView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _animationView.backgroundColor=THIEM_COLOR_LIGHTER;
        
        WS(weakSelf);
        _animationView.sendBlock=^(XYAnimationViewModel* model){
            
            if (model.isNameLeft) {
                weakSelf.commonBtn.selectModel=model;
                weakSelf.personBtn.selectModel=nil;
                
            }else{
                weakSelf.personBtn.selectModel=model;
                weakSelf.commonBtn.selectModel=nil;
            }
            
            if (weakSelf.sendBlock) {
                weakSelf.sendBlock(model);
            }
            
            tempSelectRow=-100;
            [weakSelf.myTableView reloadData];
        };
        
    }
    return _animationView;
}

- (IBAction)switchChange:(UISwitch *)sender {
    [self.holdStackView setHidden:!sender.isOn];
    
    if (self.sendBlock) {
        self.sendBlock(sender);
    }
    
    
}

-(void)addAnimationViewisCommonAddress:(BOOL)isCommonAddress{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.animationView];
    self.animationView.isCommomAddress=isCommonAddress;
    CATransition* anim=[CATransition animation];
    anim.type=@"kCATransitionFade";
    anim.duration=0.3;
    //anim.subtype=kCATransitionFromLeft;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    
}

-(void)buttonAnimationToCenter:(UIButton*)btn{
//    
//    CGRect btnF=btn.frame;
//    [UIView animateWithDuration:1 animations:^{
//        btn.layer.transform=CATransform3DMakeTranslation(btnF.origin.x, Main_Screen_Height*0.5, 0);
//    }];
    
}


- (IBAction)clickEvent:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //常见地点
            [self addAnimationViewisCommonAddress:YES];
            [self buttonAnimationToCenter:sender];
        }
            break;
        case 2:{
            //个人地点
            [self addAnimationViewisCommonAddress:NO];
            [self buttonAnimationToCenter:sender];
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
            //到达地点
            self.leaveAddressBtn.selected=NO;
            self.arriveAddressBtn.selected=YES;
            
            if (self.sendBlock) {
                self.sendBlock(sender);
            }
        }
            break;
        case 5:{
            //离开地点
            self.leaveAddressBtn.selected=YES;
            self.arriveAddressBtn.selected=NO;
            if (self.sendBlock) {
                self.sendBlock(sender);
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
}



-(void)awakeFromNib{
    [super awakeFromNib];
    
    tempSelectRow=0;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCurrentPlace:) name:kUSER_CURRENT_LOCATION_NOTIFY object:nil];
    
    [self.mySwith setTintColor:THIEM_COLOR];
    [self.mySwith setOnTintColor:THIEM_COLOR];
    
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    self.myTableView.backgroundColor=[UIColor clearColor];
    self.myTableView.scrollEnabled=NO;
    
    XYAnimationViewModel* commonBtnModel=[[XYAnimationViewModel alloc]init];
    commonBtnModel.name=@"常见地点";
    commonBtnModel.img=@"common_location";
    self.commonBtn.unselectModel=commonBtnModel;
    
    XYAnimationViewModel* personBtnModel=[[XYAnimationViewModel alloc]init];
    personBtnModel.name=@"个人地点";
    personBtnModel.img=@"personal_location";
    self.personBtn.unselectModel=personBtnModel;
    
    [self.arriveAddressBtn setTitleColor:BLACK_FONT_COLOR forState:UIControlStateNormal];
    [self.arriveAddressBtn setTitleColor:THIEM_COLOR forState:UIControlStateSelected];
    [self.leaveAddressBtn setTitleColor:BLACK_FONT_COLOR forState:UIControlStateNormal];
    [self.leaveAddressBtn setTitleColor:THIEM_COLOR forState:UIControlStateSelected];
    self.arriveAddressBtn.selected=YES;
    
    [self getHistoryAddressData];
    
}
-(void)updateCurrentPlace:(NSNotification*)notify{
    
    AMapTip* userTip=(AMapTip*)[notify.userInfo objectForKey:@"userTip"];
    
    if (self.dataArray.count==0) {
        [self.dataArray addObject:userTip];
    }else{
        AMapTip* tip_0=[self.dataArray objectAtIndex:0];
        if ([tip_0.name isEqualToString:kUSER_CURRENT_LOCATION_STRING]) {
            tip_0.name=userTip.name;
            tip_0.location=userTip.location;
        }else{
            [self.dataArray insertObject:userTip atIndex:0];
        }
    }
}
-(void)setSendBlock:(SendViewBlock)sendBlock{
    [super setSendBlock:sendBlock];
    
    [self getHistoryAddressData];

}
-(void)getHistoryAddressData{
    [self.dataArray removeAllObjects];
    
    //用户当前位置
    if ([XYUserInfo userInfo].userTip.name.length>1) {
        [self.dataArray addObject:[XYUserInfo userInfo].userTip];
        
        if (self.sendBlock) {
            self.sendBlock([XYUserInfo userInfo].userTip);
        }
    }
    //历史搜索记录
    NSArray * historyArr = [[LBSQLManager sharedInstace] selectModelArrayInDatabase:@"XYAMapTip"];
    
    if (historyArr.count<SEARCH_HISTORY_COUNT) {
        [self.dataArray addObjectsFromArray:historyArr];
    }else{
        [self.dataArray addObjectsFromArray:[historyArr objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, SEARCH_HISTORY_COUNT)]]];
    }
    
//    for (AMapTip* tip in historyArr) {
//        NSLog(@"%@",tip.name);
//    }
//    
    
    [self updateMytableHeightSelectRow:0];
}

-(void)updateMytableHeightSelectRow:(NSInteger)selectR{
    //调整表格高度
    self.myTableViewH.constant=self.dataArray.count * SEARCH_HISTORY_CELL_HEIGHT;
    
    self.personBtn.selectModel=nil;
    self.commonBtn.selectModel=nil;
    tempSelectRow=selectR;
    [self.myTableView reloadData];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifer=@"identifer";
    UITableViewCell* cell= [self.myTableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
        cell.backgroundColor=[UIColor clearColor];
        [cell.imageView setImage:[UIImage imageNamed:@"location_icon"]];
        [cell.textLabel setTextColor:BLACK_FONT_COLOR];
        [cell.detailTextLabel setTextColor:LIGHT_FONT_COLOR];
        
        UIView* backbg=[[UIView alloc]initWithFrame:cell.frame];
        backbg.backgroundColor=[XYTool stringToColor:@"#B2DFDB"];
        cell.selectedBackgroundView=backbg;
    }
    AMapTip* tip=[self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text=tip.name;
    cell.detailTextLabel.text=tip.address;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==tempSelectRow) {
        [cell setSelected:YES];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SEARCH_HISTORY_CELL_HEIGHT;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (int i=0; i<self.dataArray.count; i++) {
        UITableViewCell* cell=[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (indexPath.row!=i ) {
            cell.selected=NO;
        }
    }

    self.personBtn.selectModel=nil;
    self.commonBtn.selectModel=nil;
    
    XYAMapTip * tip=[self.dataArray objectAtIndex:indexPath.row];
    
    if (self.sendBlock) {
        self.sendBlock(tip);
    }
    
}

-(void)addNewAddress:(XYAMapTip*)tip{
    
    //第一个位置放置当前位置
    if (self.dataArray.count==1) {
        [self.dataArray addObject:tip];
    }else{
        [self.dataArray insertObject:tip atIndex:1];
    }
    
    
    if (self.dataArray.count>SEARCH_HISTORY_COUNT) {
        [self.dataArray removeObjectAtIndex:SEARCH_HISTORY_COUNT];
    }
    
    
    [self updateMytableHeightSelectRow:1];
    
    if (self.sendBlock) {
        self.sendBlock(tip);
    }
}



#pragma mark - 设置编辑按钮

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewRowAction *likeAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏到个人地点" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        XYAMapTip * tip=[self.dataArray objectAtIndex:indexPath.row];
        tip.isPersonL=YES;
        
        UIAlertController* alertCtl=[UIAlertController alertControllerWithTitle:@"请备注名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alertCtl addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
            
        }];

        UIAlertAction* action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField * textF= [alertCtl.textFields lastObject];
            if (textF.text==nil ||textF.text.length==0) {
                return ;
            }else{
                tip.remarkName=textF.text;
                [[LBSQLManager sharedInstace] creatTable:tip];
                [[LBSQLManager sharedInstace]insertAndUpdateModelToDatabase:tip];
                [XYTool showPromptView:@"添加成功" holdView:nil];
            }
            
        }];

        UIAlertAction* action3=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertCtl addAction:action1];
        [alertCtl addAction:action3];
        [[XYTool currentViewController] presentViewController:alertCtl animated:YES completion:nil];
        tableView.editing = NO;
    }];

    return @[likeAction];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
   
    return UITableViewCellEditingStyleDelete;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
