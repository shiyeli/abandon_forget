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
#import "POIAnnotation.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "AMapTipAnnotation.h"

#define POSITION_HEIGH Main_Screen_Height-150.0
#define POSITION_LOW 58.0


@interface XYAddAddressViewController ()<MAMapViewDelegate, AMapSearchDelegate, UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) NSMutableArray *tips;

@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (weak, nonatomic) IBOutlet UIView *searchHoldView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchHoldViewH;

@end

@implementation XYAddAddressViewController

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
    [self.myView addSubview:self.mapView];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.mySearchBar.delegate=self;
    
    
//    UISwipeGestureRecognizer  *upSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizer:)];
//    upSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionUp;
//    [self.searchHoldView addGestureRecognizer:upSwipeGestureRecognizer];
//
//    UISwipeGestureRecognizer  *downSwipeGestureRecognizer=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizer:)];
//    downSwipeGestureRecognizer.direction=UISwipeGestureRecognizerDirectionDown;
//    [self.searchHoldView addGestureRecognizer:downSwipeGestureRecognizer];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [panGestureRecognizer addTarget:self action:@selector(panGestureAction:)];
    [self.searchHoldView addGestureRecognizer:panGestureRecognizer];
    
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
    tips.city     = @"成都";
    tips.cityLimit = YES;// 是否限制城市
    
    [self.search AMapInputTipsSearch:tips];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.tips setArray:response.tips];
    [self.myTableView reloadData];
}


#pragma mark - tableView
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * searchCellIdentifer=@"searchCellIdentifer";
    UITableViewCell* cell=[self.myTableView dequeueReusableCellWithIdentifier:searchCellIdentifer];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCellIdentifer];
    }
    AMapTip* tempTip=[self.tips objectAtIndex:indexPath.row];
    cell.textLabel.text=tempTip.name;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tips.count;
}

#pragma mark -  UISwipeGestureRecognizer

//-(void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)recongnizer{
//    
//    
//    if (recongnizer.direction==UISwipeGestureRecognizerDirectionUp) {
//        NSLog(@"向上滑动");
//        NSLog(@"博客园-FlyElephant");
//    }
//    
//    if (recongnizer.direction==UISwipeGestureRecognizerDirectionDown) {
//        NSLog(@"向下滑动");
//        NSLog(@"原文地址:http://www.cnblogs.com/xiaofeixiang");
//    }
//
//}

#pragma mark - 实现托移手势的方法
- (void)panGestureAction:(UIPanGestureRecognizer *) sender {
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        //注意，这里取得的参照坐标系是该对象的上层View的坐标。
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
