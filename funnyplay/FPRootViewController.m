//
//  FPRootViewController.m
//  funnyplay
//
//  Created by cash on 15-8-24.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import "FPRootViewController.h"
#import "Tool.h"
#import "FetchMoreCell.h"

#import <AFNetworking.h>

@interface FPRootViewController ()

@property (nonatomic, assign) BOOL refreshInProgress;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation FPRootViewController

//初始化
- (instancetype)init
{
    if (self = [super init]) {
        _objects = [NSMutableArray new];
        _page = 0;
        _needRefreshAnimation = YES;
        _shouldFetchDataAfterLoaded = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = [UIColor themeColor];
    
    //“加载更多”
    
    /*
    _fetchMoreBtn = [UIButton new];
    _fetchMoreBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _fetchMoreBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [_fetchMoreBtn setBackgroundColor:[UIColor themeColor]];
    [_fetchMoreBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [_fetchMoreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_fetchMoreBtn setContentEdgeInsets:UIEdgeInsetsMake(15, 0, 0, 0)];
    [_fetchMoreBtn addTarget:self action:@selector(fetchMore) forControlEvents:UIControlEventTouchUpInside];
    
    _fetchMoreBtn.frame = CGRectMake(0, self.generateObjCount() * 120, self.tableView.frame.size.width, 60);
    
    [self.tableView addSubview:_fetchMoreBtn];
     */
    
    
    _moreCell = [FetchMoreCell new];
    [_moreCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchMore)]];
    self.tableView.tableFooterView = _moreCell;
     
    //“下拉刷新”
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    _label = [UILabel new];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByWordWrapping;
    _label.font = [UIFont boldSystemFontOfSize:14];
    
    
    _manager = [AFHTTPSessionManager manager];
//    [_manager.requestSerializer setValue:[Utils generateUserAgent] forHTTPHeaderField:@"User-Agent"];
//    _manager.responseSerializer = [AFOnoResponseSerializer XMLResponseSerializer];
    
    if (!_shouldFetchDataAfterLoaded) {return;}
    if (_needRefreshAnimation) {
        //不懂啊，不加也能显示啊
        [self.refreshControl beginRefreshing];
        [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y-self.refreshControl.frame.size.height)
                                animated:YES];
    }
    
    if (_needCache) {
        _manager.requestSerializer.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    }
    [self fetchObjectsOnPage:0 refresh:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _objects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.objects.count - 1) {
        return 125;
    } else {
        return 120;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}

#pragma mark - 刷新

- (void)refresh
{
    _refreshInProgress = NO;
    
    if (!_refreshInProgress) {
        _refreshInProgress = YES;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
            [self fetchObjectsOnPage:0 refresh:YES];
            
            _refreshInProgress = NO;
        });
    }
}

#pragma mark - 上拉加载更多

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height - 150)) {
        [self fetchMore];
    }
}

- (void)fetchMore
{
    
    _moreCell.status = FetchMoreCellStatusLoading;
    
    _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    [self fetchObjectsOnPage:++_page refresh:NO];
}


#pragma mark - 请求数据

- (void)fetchObjectsOnPage:(NSUInteger)page refresh:(BOOL)refresh
{
    
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
       
        _moreCell.status = FetchMoreCellStatusMore;
        
        if (self.refreshControl.refreshing) {
            [self.refreshControl endRefreshing];
        }
        
//        self.generateURL(page);
    });
   
    
    /*
    [_manager GET:self.generateURL(page)
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, ONOXMLDocument *responseDocument) {
              _allCount = [[[responseDocument.rootElement firstChildWithTag:@"allCount"] numberValue] intValue];
              NSArray *objectsXML = [self parseXML:responseDocument];
              
              if (refresh) {
                  _page = 0;
                  [_objects removeAllObjects];
//                  if (_didRefreshSucceed) {_didRefreshSucceed();}
              }
              
//              if (_parseExtraInfo) {_parseExtraInfo(responseDocument);}
              
              //检测重复
              for (ONOXMLElement *objectXML in objectsXML) {
                  BOOL shouldBeAdded = YES;
                  id obj = [[_objClass alloc] initWithXML:objectXML];
                  
                  for (OSCBaseObject *baseObj in _objects) {
                      if ([obj isEqual:baseObj]) {
                          shouldBeAdded = NO;
                          break;
                      }
                  }
                  if (shouldBeAdded) {
                      [_objects addObject:obj];
                  }
              }
              
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (self.tableWillReload) {self.tableWillReload(objectsXML.count);}
     
                  else {
                      if (_page == 0 && objectsXML.count == 0) {
                          _lastCell.status = LastCellStatusEmpty;
                      } else if (objectsXML.count == 0 || (_page == 0 && objectsXML.count < 20)) {
                          _lastCell.status = LastCellStatusFinished;
                      } else {
                          _lastCell.status = LastCellStatusMore;
                      }
                  }
                   */
        /*
                  if (self.refreshControl.refreshing) {
                      [self.refreshControl endRefreshing];
                  }
                  
                  [self.tableView reloadData];
              });
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              MBProgressHUD *HUD = [Tool createHUD:@"请稍等..."];
              HUD.dimBackground = YES;
              HUD.userInteractionEnabled = NO;
              HUD.mode = MBProgressHUDModeCustomView;
              HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD-error"]];
              HUD.detailsLabelText = [NSString stringWithFormat:@"%@", error.userInfo[NSLocalizedDescriptionKey]];
              
              [HUD hide:YES afterDelay:1];
              
//              _lastCell.status = LastCellStatusError;
              if (self.refreshControl.refreshing) {
                  [self.refreshControl endRefreshing];
              }
              [self.tableView reloadData];
          }
     ];
         */
    
}

/*
- (NSArray *)parseXML:(ONOXMLDocument *)xml
{
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}
*/



@end
