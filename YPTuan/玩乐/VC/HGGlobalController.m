//
//  HGGlobalController.m
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "HGGlobalController.h"

#define FristCellMargin 2
#define buttonViewWidth ((SCREEN_WIDTH - FristCellMargin*2)/3)
#define buttonViewHeight (buttonViewWidth/3*2)


@interface HGGlobalController ()

@property (nonatomic,copy)   NSMutableArray *nativeList;




@end

@implementation HGGlobalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.myNavBarView addSubview:self.seachV];
    [self.view addSubview:self.typeView];
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = self.typeView;
    self.typeView.sd_layout
    .topEqualToView(self.tableView)
    .leftEqualToView(self.tableView)
    .rightEqualToView(self.tableView)
    .heightIs( buttonViewHeight);
     [self _layoutFirstCell:self.typeView];
    
    
    self.tableView.mj_header = [YLMJRefreshLottioHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
 
    self.tableView.mj_footer.hidden = YES;

    self.pageSize = 10;
    self.pageIndex = 1;

    [self addData];
    
}

-(void)headerRefresh{
    if (_isLoading) return ;
    _isLoading = YES;
    self.pageIndex = 1;
    [self addData];
}

-(void)addData{
    
    [[YLHaveFunVm sharedYLHaveFunVm] getShopDataByPageindex:self.pageIndex andPagesize:self.pageSize andShopData:^(NSDictionary *returnData) {
        _isLoading = NO;
        NSArray* result = returnData[@"records"];
        
        NSLog(@"shopresult = %@",result);
        
        if (self.pageIndex == 1) {
            self.tableView.mj_header.state = MJRefreshStateIdle;
            [self.dataList removeAllObjects];
        }
        
        [self.dataList addObjectsFromArray:[YPIndexDealsModel mj_objectArrayWithKeyValuesArray:result]];
        
        if (self.dataList.count >= [returnData[@"total"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
        [self.tableView reloadData];
        
    }];
    
    
    
//    self.dataList = [YPIndexDealsModel mj_objectArrayWithKeyValuesArray:[YPIndexDealsModel getIndexDeal]];
    
    
  
}

#pragma mark -- view --

-(UIView *)typeView{
    if (!_typeView) {
        _typeView = [UIView new];
        _typeView.backgroundColor = KVCBGWhiteColor;
    }
    return _typeView;
}

-(FanyiSeachView *)seachV{
    
    if (!_seachV) {
        _seachV = [[FanyiSeachView alloc] initWithFrame:CGRectMake(20, kStatusBarHeight+2, kScreenWidth-40, 35)];
        
        WS(weakSelf);
        _seachV.block = ^{
            YLSearchController* searchVC = [YLSearchController new];
            [weakSelf.navigationController pushViewController:searchVC animated:YES];
        };
        
    }
    
    return _seachV;
}

-(YPVouchersView *)vouchersView{
    if (!_vouchersView) {
        _vouchersView = [[YPVouchersView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
    }
    return _vouchersView;
}


- (UITableView*)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kBaseTopHeight, SCREEN_WIDTH,SCREEN_HEIGHT - kBaseTopHeight - BaseBtnHeight49) style:UITableViewStylePlain];
        _tableView.backgroundColor = VCBGColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 64.f;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}



#pragma mark -@private
- (void)_layoutFirstCell:(UIView*)view{
    
    NSArray* titleArr = @[@"沐足",@"水疗",@"推拿"];
    NSArray* imgArr = @[@"shuiliao",@"shuiliao",@"tuina"];
    
    for (int i = 0; i < 3; i++) {
        GCImgTopAndTitleDownView* btn = [[GCImgTopAndTitleDownView alloc] initWithFrame:CGRectMake((buttonViewWidth+FristCellMargin)*i, 0, buttonViewWidth, buttonViewHeight) andTitle:titleArr[i] andSelcetTitle:nil andColor:kColorLogin andSelectTitleColor:nil andImg:imgArr[i] andSelectImg:nil];
        [btn layoutButtonWithImageTitleSpace:8];
        btn.backgroundColor = KVCBGWhiteColor;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
    }
  
}

-(UILabel *)sectionTitleLab{
    if (!_sectionTitleLab) {
        _sectionTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 49)];
        _sectionTitleLab.textColor = MainBackColor;
        _sectionTitleLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _sectionTitleLab.text = @"热门商家";
        _sectionTitleLab.backgroundColor = KVCBGWhiteColor;
        _sectionTitleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _sectionTitleLab;
}

#pragma mark -- event --
-(void)btnClick:(UIButton*)sender{
    
}

#pragma mark -- tableViewDelegete --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return self.dataList.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify1 = @"YPIndexDealsCell";
    YPIndexDealsCell* dealsCell = [[YPIndexDealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify1];
    if(!dealsCell){
        dealsCell = [[YPIndexDealsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify1];
    }
    
    dealsCell.model = self.dataList[indexPath.row];
    
    return dealsCell;
    

}

#pragma mark -@protocol UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    

      
    return self.sectionTitleLab;
    
   // return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0.5f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?49.f:1.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 165.f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    YLShopDetailsController* shopDetailVC = [YLShopDetailsController new];
    shopDetailVC.dealsModel = self.dataList[indexPath.row];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    
}


-(NSMutableArray *)nativeList{
    if (!_nativeList) {
        _nativeList = [NSMutableArray array];
    }
    return _nativeList;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


@end
