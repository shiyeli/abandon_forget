//
//  XYAddAddressViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAddAddressViewController.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "AMapTipAnnotation.h"
#import "XYHgithtOfKeyboard.h"
#define POSITION_HEIGH Main_Screen_Height-100.0
#define POSITION_LOW 58.0
#define REMARK_LOCATION_HEIGHT 100

@interface XYAddAddressViewController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate,XYHgithtOfKeyboardDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *tips;

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;



@property (weak, nonatomic) IBOutlet UIView *searchHoldView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHoldViewH;


@property (weak, nonatomic) IBOutlet UIView *remarkHoldView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *remarkHoldViewBottomD;
@property (weak, nonatomic) IBOutlet UILabel *addressDetail;
@property (weak, nonatomic) IBOutlet UITextField *remarkImput;

@property(nonatomic,strong)XYHgithtOfKeyboard* keyboardMgr;



@end

@implementation XYAddAddressViewController

- (IBAction)cancelRemarkClick:(id)sender {
    self.remarkHoldViewBottomD.constant=-REMARK_LOCATION_HEIGHT;
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//点击标记
- (IBAction)remarkClick:(id)sender {
    
    [self cancelRemarkClick:nil];
}


- (IBAction)accomplish:(id)sender {
    

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tips = [NSMutableArray array];
    [AMapServices sharedServices].apiKey=AMapApiKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.myView.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    self.mapView.userTrackingMode=MAUserTrackingModeFollowWithHeading;
    [self.mapView setCenterCoordinate:[XYUserInfo userInfo].userLocation.coordinate animated:NO];
    [self.myView addSubview:self.mapView];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.mySearchBar.delegate=self;
    self.mySearchBar.placeholder=@"请输入内容检索";
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [panGestureRecognizer addTarget:self action:@selector(panGestureAction:)];
    [self.searchHoldView addGestureRecognizer:panGestureRecognizer];
    
    self.keyboardMgr=[[XYHgithtOfKeyboard alloc]init];
    self.keyboardMgr.delegate=self;
    self.remarkHoldViewBottomD.constant=-REMARK_LOCATION_HEIGHT;
    
}

#pragma mark - searchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self searchTipsWithKey:searchText];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    self.searchHoldViewH.constant=POSITION_HEIGH;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    return YES;
}


/** 发起搜索*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = [XYUserInfo userInfo].userCurrentCity;
    tips.cityLimit = YES;// 是否限制城市
    
    [self.search AMapInputTipsSearch:tips];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"AMapSearchDelegate ,Error: %@", error);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.tips setArray:response.tips];
    [self.myTableView reloadData];
    [self addTipsOnmap:self.tips];
}


-(void)addTipsOnmap:(NSArray*)tips{
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    if (tips.count == 0)
    {
        return;
    }
    
    NSMutableArray *tipAnnotations = [NSMutableArray arrayWithCapacity:tips.count];
    
    [tips enumerateObjectsUsingBlock:^(AMapTip *obj, NSUInteger idx, BOOL *stop) {
        
        [tipAnnotations addObject:[[AMapTipAnnotation alloc] initWithMapTip:obj]];
    }];
    
    /* 将结果以annotation的形式加载到地图上. */
    [self.mapView addAnnotations:tipAnnotations];
    
    /* 如果只有一个结果，设置其为中心点. */
    if (tipAnnotations.count == 1)
    {
        [self.mapView setCenterCoordinate:[tipAnnotations[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        [self.mapView showAnnotations:tipAnnotations animated:NO];
    }
    
    //将第一个tip 显示信息
    [self.mapView selectAnnotation:tipAnnotations[0] animated:YES];
    
}

#pragma mark - MAMapViewDelegate

//点击大头针详情
- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([view.annotation isKindOfClass:[AMapTipAnnotation class]]){
        AMapTip* tip=[(AMapTipAnnotation *)view.annotation tip];
        [self showRemarkView:tip];
    }
}
//点击大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[AMapTipAnnotation class]])
    {
        static NSString *tipIdentifier = @"tipIdentifier";
        
        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:tipIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:tipIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        poiAnnotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        return poiAnnotationView;
    }
    
    
    return nil;
}


//长按地图
- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    CLLocation * location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    [geocoder  reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * place = placemarks[0];
        NSLog(@"点击位置: %@",place.name);
        
        AMapTip* tip=[[AMapTip alloc]init];
        tip.name=place.name;
        tip.location=[AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        AMapTipAnnotation * annotation = [[AMapTipAnnotation alloc] initWithMapTip:tip];
        
        [self.tips addObject:annotation];
        [self.mapView addAnnotation:annotation];
        [self.mapView selectAnnotation:annotation animated:YES];
        
    }];
    
    
    
}
//移动地图
- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
    

}

#pragma mark - tableView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
        cell.imageView.image = [UIImage imageNamed:@"locate"];
    }
    
    AMapTip *tip = self.tips[indexPath.row];
    
    if (tip.location == nil)
    {
        cell.imageView.image = [UIImage imageNamed:@"search"];
    }
    
    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.address;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tips.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AMapTip* tip=[self.tips objectAtIndex:indexPath.row];
    [self showRemarkView:tip];
}

-(void)showRemarkView:(AMapTip*)tip{
    self.addressDetail.text=tip.name;
    
    self.searchHoldViewH.constant=POSITION_LOW;
    self.remarkHoldViewBottomD.constant=0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

}

#pragma mark - 实现托移手势的方法
- (void)panGestureAction:(UIPanGestureRecognizer *) sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        //参照坐标系是该对象的上层View的坐标。
        CGPoint offset = [sender translationInView:self.view];
    
        self.searchHoldViewH.constant=(self.searchHoldViewH.constant-offset.y)<=POSITION_LOW? POSITION_LOW: (self.searchHoldViewH.constant-offset.y);
        self.searchHoldViewH.constant=(self.searchHoldViewH.constant-offset.y)>=POSITION_HEIGH? POSITION_HEIGH: (self.searchHoldViewH.constant-offset.y);
        [self.view layoutIfNeeded];
        if (offset.y<0) {//向上拖动
            self.searchHoldViewH.constant=POSITION_HEIGH;
        }else if(offset.y>0){
            self.searchHoldViewH.constant=POSITION_LOW;
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
        
        //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

#pragma mark - heithtOfKeyboard
-(void)heithtOfKeyboard:(CGFloat)height isShow:(BOOL)isShow{
    if (self.remarkHoldViewBottomD.constant>=0) {
        self.remarkHoldViewBottomD.constant=height;
        [UIView animateWithDuration:0.1 animations:^{
            [self.view layoutIfNeeded];
        }];
    };
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
