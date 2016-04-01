//
//  AMapViewController.m
//  funnyplay
//
//  Created by cash on 16/3/27.
//  Copyright © 2016年 ___CASH___. All rights reserved.
//

#import "AMapViewController.h"

@interface AMapViewController ()

@property (nonatomic, strong) MAMapView         *amapView;
@property (nonatomic, strong) AMapSearchAPI     *search;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AMapViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    self.amapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.amapView.delegate = self;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        [self.locationManager requestAlwaysAuthorization];
    }
    self.amapView.mapType = MAMapTypeStandard;
    
    [self.view addSubview:self.amapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}


#pragma mark - Map Delegate

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"tap: %f %f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(MAMapView *)mapView didLongPressedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"long: %f %f", coordinate.latitude, coordinate.longitude);
}

- (void)mapView:(MAMapView *)mapView mapWillMoveByUser:(BOOL)wasUserAction
{
    NSLog(@"will move byUser:%d", wasUserAction);
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction
{
    NSLog(@"did move byUser:%d", wasUserAction);
}

- (void)mapView:(MAMapView *)mapView mapWillZoomByUser:(BOOL)wasUserAction
{
    NSLog(@"will zoom byUser:%d", wasUserAction);
}

- (void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
{
    NSLog(@"did zoom byUser:%d", wasUserAction);
}



@end






























































