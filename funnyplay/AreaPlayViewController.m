//
//  AreaPlayViewController.m
//  funnyplay
//
//  Created by cash on 15-3-29.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "AreaPlayViewController.h"
#import "AreaPlay.h"
#import "LocationCell.h"
#import "Location.h"
#import "Tool.h"
#import "AMapViewController.h"

@interface AreaPlayViewController ()

@property (nonatomic, strong) NSMutableArray *allItems;

@end

@implementation AreaPlayViewController


#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (!self) {
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)commonInit {
    
    self.navigationItem.title = @"角落一个不落";
    
    self.allItems = [[NSMutableArray alloc] init];
    NSArray *arrayData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"areaPlay.plist" ofType:nil]];
    
    for (NSDictionary *dict in arrayData) {
        //areaPlay
        AreaPlay *areaPlay = [AreaPlay areaPlayWithDict:dict];
        [self.allItems addObject:areaPlay];
    }
    
    //"都在这里"
    UIBarButtonItem *btnIsHere = [[UIBarButtonItem alloc] initWithTitle:@"都在这里" style:UIBarButtonItemStyleDone target:self action:@selector(clickIsHere:)];
    self.navigationItem.rightBarButtonItem = btnIsHere;
    
    /*
     NSMutableArray *rightBarButtonArray = [[NSMutableArray alloc] initWithCapacity:2];
     
     UIBarButtonItem *btnPic = [[UIBarButtonItem alloc] initWithTitle:@"＋图片" style:UIBarButtonItemStyleBordered target:self action:@selector(clickImgs:)];
     [rightBarButtonArray addObject:btnPic];
     UIBarButtonItem *btnPub = [[UIBarButtonItem alloc] initWithTitle:@"动弹一下" style:UIBarButtonItemStyleBordered target:self action:@selector(click_PubTweet:)];
     [rightBarButtonArray addObject:btnPub];
     
     if(IS_IOS7)
     [customToolbar setFrame:CGRectMake(0, 0, 135,47)];
     [customToolbar setItems:rightBarButtonArray animated:NO];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:customToolbar];
     
     
     // rightBarButtonItem = (UIBarButtonItem)initWithCustomView(toolbar setItem(rightArray(btnPic, btnPub)))
     
     */
}

- (void)viewDidLoad {
    
    // addSubViews
    
    [self.tableView registerClass:[LocationCell class] forCellReuseIdentifier:[LocationCell cellId]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Event response

// 高德地图
- (void) clickIsHere:(id)sender {
    
    AMapViewController *amapVC = [[AMapViewController alloc] init];
    [self.navigationController pushViewController:amapVC animated:YES];
}


#pragma mark - Private methods



#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_allItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    AreaPlay *areaPlay = _allItems[section];
    NSArray *areaPlays = [areaPlay areaPlays];
    return [areaPlays count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [_allItems[section] locArea];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:[LocationCell cellId] forIndexPath:indexPath];
    
    AreaPlay *areaPlay = _allItems[indexPath.section];
    cell.location = areaPlay.locations[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDataDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AreaPlay *areaPlay = _allItems[indexPath.section];
    Location *loc = areaPlay.locations[indexPath.row];
    if (loc) {
        //self.parentViewController.title = loc.itemName;
        //        self.parentViewController.tabBarItem.title = @"评论";
        
        [Tool pushLocationDetail:loc andNavController:self.navigationController];
    }
    
    /* 两个一样
     if (self.navigationController == self.parentViewController.navigationController) {
     NSLog(@"yes");
     NSLog(@"%@", self.navigationController);
     NSLog(@"%@", self.parentViewController.navigationController);
     }
     */
}


#pragma mark - CustomDelegate



#pragma mark - Getters & Setters




@end








