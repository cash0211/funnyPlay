//
//  MapViewBaseViewController.h
//  funnyplay
//
//  Created by cash on 15-5-18.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI/BMapKit.h>

@interface MapViewBaseViewController : UIViewController<BMKMapViewDelegate, BMKLocationServiceDelegate> {
    
    __weak IBOutlet BMKMapView *_mapView;
    
    BMKLocationService *_locService;
}

@end
