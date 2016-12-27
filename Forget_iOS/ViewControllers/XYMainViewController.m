//
//  XYMainViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//


/*************** XYNotifyListCell *****************/

#import "XYParentTableViewCell.h"


@interface XYNotifyListCell : XYParentTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *notifyTitle;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property(nonatomic,strong)XYNotifyModel* model;

@end

@implementation XYNotifyListCell

-(void)setModel:(XYNotifyModel *)model{
    _model=model;
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
@property (weak, nonatomic) IBOutlet XYNotifyListHeaderView *notifyHeaderView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *notifyHeaderViewH;


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
    
    [self settingsOfSlide];
    
    self.notifyHeaderViewH.constant=Main_Screen_Width*0.5;
    
    [self getNotifyData];
    
    UIView* footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64-self.notifyHeaderViewH.constant-NOTIFYLIST_CELL_HEIGHT)];
    self.myTableView.tableFooterView=footerView;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addNewRemind:) name:kADD_NEW_REMIND_NOTIFY object:nil];
}



-(void)addNewRemind:(NSNotification*)notify{
    XYNotifyModel* model=[notify.userInfo objectForKey:NSStringFromClass([XYNotifyModel class])];
    if (self.dataArray.count>0) {
        [self.dataArray insertObject:model atIndex:0];
    }else{
        [self.dataArray addObject:model];
    }
    if (self.dataArray.count>0) {
        self.notifyHeaderView.model=[self.dataArray objectAtIndex:0];
    }
    [self.myTableView reloadData];
    
    self.myTableView.scrollsToTop=YES;
    
}
-(void)getNotifyData{

    NSArray * historyArr=[[LBSQLManager sharedInstace]selectModelArrayInDatabase:@"XYNotifyModel"];
    [self.dataArray addObjectsFromArray:historyArr];

    for (XYNotifyModel* model in self.dataArray) {
        
        //读取图片
        if (model.notifyImg64Str) {
            NSData *_decodedImageData  = [[NSData alloc] initWithBase64EncodedString:model.notifyImg64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
            model.notifyImg = [UIImage imageWithData:_decodedImageData];
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
    }
    

    for (XYNotifyModel* mode in historyArr) {
        NSLog(@"%@",mode.notifyRemark);
    }
    
    if (self.dataArray.count>0) {
        self.notifyHeaderView.model=[self.dataArray objectAtIndex:0];
        [self.view layoutIfNeeded];
    }
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
    NSArray* visibleCells=self.myTableView.visibleCells;
    if (visibleCells.count>0) {
       XYNotifyListCell* cell= [visibleCells objectAtIndex:0];
        self.notifyHeaderView.model=cell.model;
    }
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
