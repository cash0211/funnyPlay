//
//  FPRootViewController.h
//  funnyplay
//
//  Created by cash on 15-8-24.
//  Copyright (c) 2015年 ___CASH___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AFNetworking.h>
//#import <AFOnoResponseSerializer.h>
//#import <Ono.h>

#import "FPAPI.h"
#import "FetchMoreCell.h"

@interface FPRootViewController : UITableViewController

@property (nonatomic, copy) NSString * (^generateURL)(NSUInteger page);  //生成网络请求URL
//@property (nonatomic, copy) NSUInteger (^generateObjCount)();  

//@property Class objClass;

@property (nonatomic, assign) BOOL shouldFetchDataAfterLoaded;
@property (nonatomic, assign) BOOL needRefreshAnimation;
@property (nonatomic, assign) BOOL needCache;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, assign) int allCount;
@property (nonatomic, strong) FetchMoreCell *moreCell;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSUInteger page;

//- (NSArray *)parseXML:(ONOXMLDocument *)xml;
- (void)fetchMore;
- (void)refresh;


@end