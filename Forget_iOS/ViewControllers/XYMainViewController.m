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
    
    [self getNotifyData];
    
    self.notifyHeaderViewH.constant=Main_Screen_Width*0.5;
}

-(void)getNotifyData{
    
    for (int i=0; i<10; i++) {
        XYNotifyModel* model=[[XYNotifyModel alloc]init];
        model.haveSetTime=YES;
        model.haveSetLocation=YES;
        model.notifyRemark=@"提醒备注信息";
        [self.dataArray addObject:model];
    }
    if (self.dataArray.count>0) {
        self.notifyHeaderView.model=[self.dataArray objectAtIndex:0];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
