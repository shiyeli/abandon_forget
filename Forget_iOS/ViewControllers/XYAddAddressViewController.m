//
//  XYAddAddressViewController.m
//  Forget_iOS
//
//  Created by 叶同学 on 2016/10/26.
//  Copyright © 2016年 叶同学. All rights reserved.
//

#import "XYAddAddressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "POIAnnotation.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "AMapTipAnnotation.h"
@interface XYAddAddressViewController ()<MAMapViewDelegate, AMapSearchDelegate, UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) AMapSearchAPI *search;




@property (nonatomic, strong) NSMutableArray *tips;
@property (nonatomic, strong) NSMutableArray *busLines;

@end

@implementation XYAddAddressViewController

- (IBAction)accomplish:(id)sender {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (id)init
{
    if (self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
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
