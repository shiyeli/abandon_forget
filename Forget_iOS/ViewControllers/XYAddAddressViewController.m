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
#define SEARCH_POSITION_HEIGH (Main_Screen_Height-20.0)
#define SEARCH_POSITION_MIDDLE (Main_Screen_Height * 0.4)
#define SEARCH_POSITION_LOW 120.0
#define DURATION_TIME_LONG 0.3
#define DURATION_TIME_SHOT 0.2

@interface XYAddAddressViewController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate,XYHgithtOfKeyboardDelegate,UITextFieldDelegate>

{
    UIView * coverView;
}

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *tips;

@property (weak, nonatomic) IBOutlet UIView *myView;


@property (weak, nonatomic) IBOutlet UIImageView *sliderImgView;




@property (weak, nonatomic) IBOutlet UIView *textFieldHoldView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchClearBtn;



@property (weak, nonatomic) IBOutlet UITableView *myTableView;



@property (weak, nonatomic) IBOutlet UIView *searchHoldView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHoldViewH;


@property(nonatomic,strong)XYHgithtOfKeyboard* keyboardMgr;



@end

@implementation XYAddAddressViewController

- (IBAction)clearTextField:(UIButton *)sender {
    self.searchTextField.text=nil;
    [sender setHidden:YES];
}

- (IBAction)accomplish:(id)sender {
    

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //状态栏
    self.navigationController.navigationBar.barStyle=UIBarStyleDefault;//颜色
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];//模糊
    effectView.frame = CGRectMake(0, 0, Main_Screen_Width, 20);
    effectView.alpha=0.9;
    [self.view addSubview:effectView];
    
    //地图类别
    self.tips = [NSMutableArray array];
    [AMapServices sharedServices].apiKey=AMapApiKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.myView.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation=YES;
    self.mapView.showsCompass=NO;
    self.mapView.showsScale=NO;
    self.mapView.userTrackingMode=MAUserTrackingModeFollowWithHeading;
    [self.mapView setCenterCoordinate:[XYUserInfo userInfo].userLocation.coordinate animated:NO];
    [self.myView addSubview:self.mapView];
    
    //搜索地址
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.searchTextField.delegate=self;
    self.searchTextField.placeholder=@"搜索地点...";
    self.searchTextField.tintColor=THIEM_COLOR;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchContentChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.searchClearBtn setHidden:YES];
    
    //输入框上方阴影
    self.textFieldHoldView.layer.cornerRadius=5;
    self.textFieldHoldView.layer.shadowColor=[UIColor blackColor].CGColor;
    self.textFieldHoldView.layer.shadowRadius=5;
    self.textFieldHoldView.layer.shadowOffset=CGSizeMake(0, 0);
    self.textFieldHoldView.layer.shadowOpacity=0.5;
    self.textFieldHoldView.backgroundColor=[UIColor whiteColor];
    
    //下方输入框滑动
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [panGestureRecognizer addTarget:self action:@selector(panGestureAction:)];
    self.sliderImgView.userInteractionEnabled=YES;
    [self.sliderImgView addGestureRecognizer:panGestureRecognizer];
    self.keyboardMgr=[[XYHgithtOfKeyboard alloc]init];
    self.keyboardMgr.delegate=self;
    
    self.searchHoldViewH.constant=SEARCH_POSITION_LOW;
    
    //返回确定按钮
    UIButton* backBtn=[[UIButton alloc]init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"map_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(navigationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.tag=kTag+1;
    [self.myView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.myView).with.offset(16);
        make.top.equalTo(self.myView).with.offset(25);
        
    }];
    
    UIButton* sureBtn=[[UIButton alloc]init];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"map_sure"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(navigationBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag=kTag+2;
    [self.myView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.myView).with.offset(-16);
        make.centerY.equalTo(backBtn);
    }];
    
    
}

//确定 or 取消
-(void)navigationBtnAction:(UIButton*)sender{
    if (sender.tag==kTag+1) {
        
    }else{
    
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - searchBarDelegate
-(void)searchContentChange:(NSNotification*)notify{
    NSString* contentStr=[notify.object valueForKey:@"text"];
    [self searchTipsWithKey:contentStr];
    [self.searchClearBtn setHidden:contentStr.length==0];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self addGrayViewPostion:SEARCH_POSITION_HEIGH duration:DURATION_TIME_LONG];
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
       // AMapTip* tip=[(AMapTipAnnotation *)view.annotation tip];
       
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
//- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction{
//    if (wasUserAction) {
//        
//        
//        
//        CGPoint p;
//        if (mapView.selectedAnnotations.count>0) {
//            mapView.scrollEnabled=NO;
//            AMapTipAnnotation* tipAnno =[mapView.selectedAnnotations firstObject];
//            p=[mapView convertCoordinate:tipAnno.coordinate toPointToView:mapView];
//            NSLog(@"%f,%f",p.x,p.y);
//            
//            
//            
//        }else{
//            mapView.scrollEnabled=YES;
//        }
//        
//        for (AMapTipAnnotation* anno in mapView.selectedAnnotations) {
//            
//        }
//        
//    
//    }
//
//}

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
    
    //AMapTip* tip=[self.tips objectAtIndex:indexPath.row];

    [self addGrayViewPostion:SEARCH_POSITION_LOW duration:DURATION_TIME_LONG];
}


#pragma mark - 实现托移手势的方法
- (void)panGestureAction:(UIPanGestureRecognizer *) sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //参照坐标系是该对象的上层View的坐标。
        CGPoint offset = [sender translationInView:self.view];
    
        self.searchHoldViewH.constant=self.searchHoldViewH.constant-offset.y;
        CGFloat durationTime=0;
        if (offset.y<0) {//向上拖动
            if (self.searchHoldViewH.constant>SEARCH_POSITION_LOW&&self.searchHoldViewH.constant<SEARCH_POSITION_MIDDLE) {
                self.searchHoldViewH.constant=SEARCH_POSITION_MIDDLE;
                durationTime=DURATION_TIME_SHOT;
            }else if (self.searchHoldViewH.constant>SEARCH_POSITION_MIDDLE+1){
                self.searchHoldViewH.constant=SEARCH_POSITION_HEIGH;
                durationTime=DURATION_TIME_LONG;
            }
        }else if(offset.y>0){
            if (self.searchHoldViewH.constant>SEARCH_POSITION_MIDDLE&&self.searchHoldViewH.constant<SEARCH_POSITION_HEIGH) {
                self.searchHoldViewH.constant=SEARCH_POSITION_MIDDLE;
                durationTime=DURATION_TIME_LONG;
            }else if (self.searchHoldViewH.constant<SEARCH_POSITION_MIDDLE){
                self.searchHoldViewH.constant=SEARCH_POSITION_LOW;
                durationTime=DURATION_TIME_SHOT;
            }
        }
        [UIView animateWithDuration:durationTime animations:^{
            [self.view layoutIfNeeded];
        }];
        
        //初始化sender中的坐标位置。如果不初始化，移动坐标会一直积累起来。
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
        [self addGrayViewPostion:self.searchHoldViewH.constant duration:DURATION_TIME_LONG];
    }
}

-(void)addGrayViewPostion:(CGFloat)postion duration:(CGFloat)duration{
    
    
    self.searchHoldViewH.constant=postion;
    [UIView animateWithDuration:DURATION_TIME_LONG animations:^{
        [self.view layoutIfNeeded];
    }];
    
    if (self.searchHoldViewH.constant==SEARCH_POSITION_HEIGH) {
        if (!coverView) {
            coverView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
            coverView.backgroundColor=[UIColor blackColor];
            coverView.alpha=0.0;
        }
        [UIView animateWithDuration:DURATION_TIME_LONG animations:^{
            coverView.alpha=0.4;
        }];
        [self.myView addSubview:coverView];
        [self.myView bringSubviewToFront:self.searchHoldView];
    }else{
        [UIView animateWithDuration:DURATION_TIME_LONG animations:^{
            coverView.alpha=0.0;
        }];
        [coverView removeFromSuperview];
    }
}

#pragma mark - heithtOfKeyboard
-(void)heithtOfKeyboard:(CGFloat)height isShow:(BOOL)isShow{
    



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
