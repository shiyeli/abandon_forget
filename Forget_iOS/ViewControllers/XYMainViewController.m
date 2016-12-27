//
//  XYMainViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//


/*************** XYNotifyListCell *****************/

#import "XYParentTableViewCell.h"
#import "XYNotifyListHeaderView.h"

@interface XYNotifyListCell : XYParentTableViewCell


@property (weak, nonatomic) IBOutlet XYNotifyListHeaderView *cellHeaderView;


@property (weak, nonatomic) IBOutlet UILabel *notifyTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property(nonatomic,strong)XYNotifyModel* model;

@end

@implementation XYNotifyListCell



-(void)setModel:(XYNotifyModel *)model{
    _model=model;

    _cellHeaderView.model=model;

    _notifyTitle.text=_model.notifyRemark;
    
    if (_model.haveSetLocation&&_model.haveSetTime) {
        [_img1 setImage:[UIImage imageNamed:@"notify_list_time"]];
        [_img2 setImage:[UIImage imageNamed:@"notify_list_location"]];
    }else if (_model.haveSetTime){
        [_img2 setImage:[UIImage imageNamed:@"notify_list_time"]];
    }else if (_model.haveSetLocation){
        [_img2 setImage:[UIImage imageNamed:@"notify_list_location"]];
    }
    
}

@end
/*************** XYNotifyListCell *****************/



#import "XYMainViewController.h"
#import "SWRevealViewController.h"
#import "XYNotifyListHeaderView.h"
#define NOTIFYLIST_CELL_HEIGHT 44.0f
#import "LBSQLManager.h"


@interface XYMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray * dataArray;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation XYMainViewController

-(NSMutableArray*)dataArray{
    if (!_dataArray) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //设置视图顶部阴影
        UIView* shadowView=[[UIView alloc]initWithFrame:CGRectMake(-10, -10, Main_Screen_Width+20, 10)];
        shadowView.backgroundColor=[UIColor blackColor];
    
        shadowView.layer.shadowColor=[UIColor blackColor].CGColor;
        shadowView.layer.shadowOffset= CGSizeMake(0, 3);
        shadowView.layer.shadowRadius=5;
        shadowView.layer.shadowOpacity=0.5;
        [self.view addSubview:shadowView];
    
    
    [self settingsOfSlide];

    [self getNotifyData];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addNewRemind:) name:kADD_NEW_REMIND_NOTIFY object:nil];
}



-(void)addNewRemind:(NSNotification*)notify{
    
    XYNotifyModel* model=[notify.userInfo objectForKey:NSStringFromClass([XYNotifyModel class])];
    if (self.dataArray.count>0) {
        [self.dataArray insertObject:model atIndex:0];
    }else{
        [self.dataArray addObject:model];
    }
   
    [self.myTableView reloadData];
    
    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}
-(void)getNotifyData{

    NSArray * historyArr=[[LBSQLManager sharedInstace]selectModelArrayInDatabase:@"XYNotifyModel"];
    [self.dataArray addObjectsFromArray:historyArr];

    for (XYNotifyModel* model in self.dataArray) {
        
        //读取图片
        if (model.notifyImg64Str) {
            NSData *_decodedImageData  = [[NSData alloc] initWithBase64EncodedString:model.notifyImg64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
            model.notifyImg = [UIImage imageWithData:_decodedImageData];
        }else{
            model.notifyImg=nil;
        }
        
        
        if (model.isPersonalLocation) {
            AMapTip * tip=[[AMapTip alloc]init];
            tip.uid=model.uid;
            tip.name=model.name;
            tip.adcode=model.adcode;
            tip.district=model.district;
            tip.address=model.address;
            
            AMapGeoPoint * point=[[AMapGeoPoint alloc]init];
            point.latitude=model.latitude;
            point.longitude=model.longitude;
            tip.location=point;

            model.tip=tip;
        }
        
        if (model.haveSetTime) {
            if ([model.notifyTime isKindOfClass:[NSString class]]) {
                NSDate* notifyDate = [NSDate dateWithTimeIntervalSince1970:[(NSString*)model.notifyTime doubleValue]];
                model.notifyTime=notifyDate;
            }
        }
        
        if (model.haveSetRepeat) {
            model.repeatUnit=model.repeatUnitSave;
            model.repeatUnitArr=TimeSetRepeatCircleArr;
            
        }
        
        if (model.haveSetClosingDate) {
            if ([model.closingDate isKindOfClass:[NSString class]]) {
                NSDate* closeTime = [NSDate dateWithTimeIntervalSince1970:[(NSString*)model.closingDate doubleValue]];
                model.notifyTime=closeTime;
            }
        } 
    }
    

    for (XYNotifyModel* mode in historyArr) {
        NSLog(@"%@",mode.notifyRemark);
    }
    
    [self.view layoutIfNeeded];
    [self.myTableView reloadData];
}

-(void)settingsOfSlide{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    UIBarButtonItem *revealButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"slider_view_btn"]style:UIBarButtonItemStylePlain target:revealController action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = revealButtonItem;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickOnView:(UIButton *)sender {
    switch (sender.tag) {
        case 1:{
            //添加提醒事件
            UINavigationController* AddEventNavi=[[UIStoryboard storyboardWithName:@"AddEvent" bundle:nil] instantiateInitialViewController];
            [self presentViewController:AddEventNavi animated:YES completion:^{
                
            }];
            
            
        }
            break;
         
        
        default:
            break;
    }
    
    
}

#pragma mark tableView

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier=@"XYNotifyListCell";
    XYNotifyListCell* cell=[self.myTableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell=[self.myTableView dequeueReusableCellWithIdentifier:identifier];
    }
    cell.model=[self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSArray* visibleCells=self.myTableView.visibleCells;
//    if (visibleCells.count>1) {
//        XYNotifyListCell* cell=[visibleCells objectAtIndex:0];
//        cell.selected=NO;
//    }
//    
//    XYNotifyListCell* cell=[self.myTableView cellForRowAtIndexPath:indexPath];
//    self.notifyHeaderView.model=cell.model;
//}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //设置Cell的动画效果为3D效果
//    //设置x和y的初始值为0.1；
//    cell.layer.transform = CATransform3DMakeScale(1,0.1, 1);
//    //x和y的最终值为1
//    [UIView animateWithDuration:0.3 animations:^{
//        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
//    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSArray* visibleCells=self.myTableView.visibleCells;
//    for (int i=0; i<visibleCells.count; i++) {
//        
//        XYNotifyListCell* cell= [visibleCells objectAtIndex:i];
//        if (i==0) {
//            self.notifyHeaderView.model=cell.model;
//            cell.selected=YES;
//        }else{
//            cell.selected=NO;
//        }
//    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
