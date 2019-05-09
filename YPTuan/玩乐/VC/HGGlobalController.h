//
//  HGGlobalController.h
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "BaseVC.h"
#import "SDCycleScrollView.h"
#import "CustomButton.h"
#import "YPGlobalModel.h"
#import "YPVouchersView.h"
#import "YPIndexDealsCell.h"
#import "YPIndexDealsModel.h"
#import "FanyiSeachView.h"
#import "GCImgTopAndTitleDownView.h"
#import "YLSearchController.h"
#import "YLShopDetailsController.h"
#import "YLHaveFunVm.h"



@interface HGGlobalController : BaseVC<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>


@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YPVouchersView *vouchersView;
@property (nonatomic,strong) FanyiSeachView* seachV ;

@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) UILabel *sectionTitleLab;

@property (nonatomic,strong) UIView *typeView;

-(void)addData;

@end
