//
//  YLTechnician Controller.m
//  YPTuan
//
//  Created by gd on 2018/11/23.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLTechnicianController.h"
#import "WaterflowView.h"
#import "YLBeautyShowView.h"
#import "YLArtificerModel.h"
#import "YLHaveFunVm.h"
#import "YLTechnicianDealViewController.h"
@interface YLTechnicianController ()<WaterflowViewDataSource,WaterflowViewDelegate>
@property (nonatomic,strong) WaterflowView* waterflowView;
@property (nonatomic,strong) LOTAnimationView *lottieLogo;
@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) BOOL isLoading;
@property (nonatomic,assign) NSInteger pageIndex;
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation YLTechnicianController
WYGetter_MutableArray(dataList)
- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"技师列表";
    [self.view addSubview:self.waterflowView];
    
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 30, kBaseTopHeight, 30));
    
    
    self.pageSize = 20;

    [self.waterflowView.mj_header beginRefreshing];
    
   
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lottieLogo stop];
}

-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"empty_data"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

-(WaterflowView*)waterflowView
{
    if (!_waterflowView) {
        // 0.初始化数据
        //        NSArray *newShops = [HMShopModel objectArrayWithFilename:@"2.plist"];
        
        _waterflowView = [[WaterflowView alloc] initWithFrame:CGRectMake(0, kBaseTopHeight, kScreenWidth, kScreenHeight-kBaseTopHeight)];
        _waterflowView.dataSource = self;
        _waterflowView.delegate = self;
       // _waterflowView.frame = ;
        _waterflowView.backgroundColor = KVCBGWhiteColor;
        
       _waterflowView.mj_header = [YLMJRefreshLottioHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
        
        _waterflowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (_isLoading) return ;
            _isLoading = YES;
            self.pageIndex ++;
            [self getData];
        }];
        
    }
    return _waterflowView;
}

-(void)loadNewShops{
    if (_isLoading) return ;
    _isLoading = YES;
    self.pageIndex = 1;
    [self getData];
}



-(void)getData{
    
    if (_isCollect) {
     
        [[YLHaveFunVm sharedYLHaveFunVm] getMyCollectByPageindex:self.pageIndex andPagesize:self.pageSize andUsername:UserModelSisingle.userName andType:YLMerchantOrArtificerTypeArtificer andCollectData:^(NSArray *data, NSInteger totle) {
            
             [self dealWithData:data andTotle:totle];
        }];
        return;
    }
   
    [[YLHaveFunVm sharedYLHaveFunVm] getArrificerByPageindex:self.pageIndex andPagesize:self.pageSize andMerchantId:self.merchantId andArrificerData:^(NSArray *data, NSInteger totle) {
        [self dealWithData:data andTotle:totle];
    }];
   
}

-(void) dealWithData:(NSArray*)data andTotle:(NSInteger)totle{
    _isLoading = NO;
    
    if (self.pageIndex == 1) {
        self.waterflowView.mj_header.state = MJRefreshStateIdle;
        [self.dataList removeAllObjects];
    }
    NLog(@"data %lu",(unsigned long)data.count);
    [self.dataList addObjectsFromArray:data];
    
    if (self.dataList.count >= totle) {
        [self.waterflowView.mj_footer endRefreshingWithNoMoreData];
    }else{
        self.waterflowView.mj_footer.state = MJRefreshStateIdle;
    }
    
    if (self.dataList.count > 0) {
        self.lottieLogo.hidden = YES;
        self.waterflowView.mj_footer.hidden = NO;
        [self.lottieLogo pause];
    }else{
        self.lottieLogo.hidden = NO;
        self.waterflowView.mj_footer.hidden = YES;
        [self.lottieLogo play];
    }
    
    [self.waterflowView reloadData];
}

#pragma mark - 瀑布流数据源方法

-(NSUInteger)numberOfColumnsInWaterflowView:(WaterflowView *)waterflowView{
    return 2;
}

-(NSUInteger)numberOfcellsInWaterflowView:(WaterflowView *)waterflowView
{
    return self.dataList.count;
}
-(WaterflowViewCell *)waterflowView:(WaterflowView *)waterflowView cellAtIndex:(NSUInteger)index
{
    
    YLBeautyShowView* cell = [YLBeautyShowView cellWithWaterflowView:waterflowView];
    cell.artificerModel = self.dataList[index];
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)waterflowView:(WaterflowView *)waterflowView heightAtIndex:(NSUInteger)index
{
    switch (index % 2) {
        case 0: return 150;
        case 1: return 170;
        case 2: return 200;
        default: return 180;
    }
    //    YLTechnicianModel *model = self.dataList[index];
    //    return waterflowView.cellWidth*model.h/model.w;
}

-(void)waterflowView:(WaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index
{
    NLog(@"点击了%lu",(unsigned long)index);
    YLTechnicianDealViewController* technicianVc = [YLTechnicianDealViewController new];
    technicianVc.hidesBottomBarWhenPushed = YES;
    technicianVc.artificerModel = self.dataList[index];
    [self.navigationController pushViewController:technicianVc animated:YES];
}


@end
