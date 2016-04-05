//
//  LocationViewController.m
//  funnyplay
//
//  Created by cash on 15-3-16.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "LocationViewController.h"
#import "LocationCell.h"
#import "Location.h"
#import "LocationDetail.h"
#import "Tool.h"
#import "Location.h"

@interface LocationViewController ()

@end

@implementation LocationViewController


#pragma mark - Lifecycle

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    //        __weak LocationViewController *weakSelf = self;
    self.generateURL = ^NSString * (NSUInteger page) {
        
        NSString *str1 = [NSString stringWithFormat:@"%@%@?pageIndex=%lu&%@", FPAPI_PREFIX, FPAPI_LOCATION_LIST, (unsigned long)page, FPAPI_SUFFIX];
        
        NSLog(@"%@", str1);
        
        return str1;
    };
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"南京";
    
    //"附近"
    UIBarButtonItem *btnNearbyTitle = [[UIBarButtonItem alloc] initWithTitle:@"附近" style:UIBarButtonItemStyleDone target:self action:@selector(clickNearby:)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn addTarget:self action:@selector(clickNearby:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"nearby"] forState:UIControlStateNormal];
    UIBarButtonItem *btnNearby = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:btnNearbyTitle, btnNearby, nil];
    
    //"区域玩" --- 直接 BarButtonItem
    UIBarButtonItem *btnAreaPlay = [[UIBarButtonItem alloc] initWithTitle:@"区域玩" style:UIBarButtonItemStyleDone target:self action:@selector(clickAreaPlay:)];
    self.navigationItem.rightBarButtonItem = btnAreaPlay;
    
    // data
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"location.plist" ofType:nil]];
    
    for (NSDictionary* dict in arrayData) {
        Location *loc = [Location locationWithDict:dict];
        
        [self.objects addObject:loc];
    }
    
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:[LocationCell cellId]];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // layout
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response

- (void)clickAreaPlay:(id)sender {
    
    [Tool pushAreaPlay:sender andNavController:self.navigationController];
}

- (void)clickNearby:(id)sender {
    
}


#pragma mark - Public methods



#pragma mark - Private methods



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[LocationCell cellId] forIndexPath:indexPath];
    
    cell.location = self.objects[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count - 1) {
        return 125;
    } else {
        return 120;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Location *loc = self.objects[indexPath.row];
    if (loc) {
        //self.parentViewController.title = loc.itemName;
        //        self.parentViewController.tabBarItem.title = @"评论";
        
        [Tool pushLocationDetail:loc andNavController:self.navigationController];
    }
}


#pragma mark - CustomDelegate





@end
