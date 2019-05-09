//
//  HGCarController.m
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "HGCarController.h"
#import "YLOrderCellView.h"
#import "YLOrderDealsVM.h"
#import "YLOrderDealsController.h"


@interface HGCarController ()

@property (nonatomic,strong) LOTAnimationView *lottieLogo;
@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation HGCarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myNavBarView.hidden = YES;
    
   
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(0, 0,kBaseTopHeight , 0));
    
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 50, kBaseTopHeight, 50));
    
    self.pageSize = 15;
    self.pageIndex = 1;
    
   
    
    [self showHeaderRefresh:YES];
    [self showLoadMoreControl:YES];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UserModelSisingle.userId.length <= 0) {
        self.lottieLogo.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
        [self.lottieLogo play];
    }else{
         [self loadData];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}
-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"empty_box"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
        _lottieLogo.hidden = YES;
    }
    return _lottieLogo;
}

#pragma mark --data --
-(void)loadData{
    [[YLOrderDealsVM sharedYLOrderDealsVM] getUserOderByPageindex:self.pageIndex andPagesize:self.pageSize andUsename:UserModelSisingle.userName andType:self.type andArtificerData:^(NSArray *data, NSInteger totle) {
        [self dealWithData:data andTotle:totle];
    }];
}

-(void) dealWithData:(NSArray*)data andTotle:(NSInteger)totle{
    self.isLoading = NO;
    
    if (self.pageIndex == 1) {
        self.tableView.mj_header.state = MJRefreshStateIdle;
        [self.dataList removeAllObjects];
    }
    NLog(@"data %lu",(unsigned long)data.count);
    [self.dataList addObjectsFromArray:data];
    
    if (self.dataList.count >= totle) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.dataList.count > 0) {
        self.lottieLogo.hidden = YES;
        self.tableView.mj_footer.hidden = NO;
        [self.lottieLogo pause];
    }else{
        self.lottieLogo.hidden = NO;
        self.tableView.mj_footer.hidden = YES;
        [self.lottieLogo play];
    }
    
    [self.tableView reloadData];
}

#pragma mark -- tableViewDelegete --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataList.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cells";
    YLOrderCellView *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[YLOrderCellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.backgroundColor = VCBGColor;
        
    }
    
    cell.orderModel = self.dataList[indexPath.section];
    
    return cell;
}

#pragma mark -@protocol UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?1.f:0.5f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return OrderCellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"YLOrderPray" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    YLOrderDealsController* orderVC = [YLOrderDealsController new];
    orderVC.urlString = [url absoluteString] ;
    [self.navigationController pushViewController:orderVC animated:YES];
    
    
}

WYGetter_MutableArray(dataList)



@end
