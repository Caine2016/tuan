//
//  HGMeController.m
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "HGMeController.h"
#import "YLMyHeaderView.h"
#import "YLLoginController.h"
#import "YLCenterModel.h"
#import "YLCenterVM.h"
#import "HGSetUpSelectCell.h"
#import "YLSettingController.h"
#import "YLUserModel.h"
#import "YLTechnicianController.h"
#import "YLMerchantController.h"
#import "YLOrderDealsController.h"
#import "YLMemberCenterController.h"
@interface HGMeController ()

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) YLMyHeaderView *headerView;

@end

@implementation HGMeController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.customTitle = @"我的";
    self.myNavBarView.hidden = YES;
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(-40, 0, 0, 0));
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.backgroundColor = kColorTitleLIGHTGRAYNormal;
    self.headerView.sd_layout
   // .topSpaceToView(self.tableView, kStatusBarHeight+30)
    .topEqualToView(self.tableView)
    .leftSpaceToView(self.tableView, 0)
    .rightEqualToView(self.tableView)
    .heightIs(250);
    
    [self setCenterData];
    
    [GDNotificationCenter addObserver:self selector:@selector(loginOrLogOut) name:LoginOrLogOutNotification object:nil];
    
    [self loginOrLogOut];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.headerView.lottieLogo play];
    
    
    CNSLog(@"%@--userid",[UserModelSisingle userId]);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.headerView.lottieLogo pause];
}

-(void)dealloc{
    [GDNotificationCenter removeObserver:self name:LoginOrLogOutNotification object:nil];
}
#pragma mark --not--
-(void)loginOrLogOut{
    [self.headerView updataView];
}

#pragma mark -- view --

-(YLMyHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [YLMyHeaderView new];
        WS(weakSelf);
        _headerView.didHeaderViewBlock = ^{
            
            if ([UserModelSisingle userId].length <= 0) {
                YLLoginController* loginVC = [YLLoginController new];
                loginVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:loginVC animated:YES];
                return ;
            }
            
         
        };
        _headerView.didSettingTapBlock = ^{
            YLSettingController* settingVC = [YLSettingController new];
            [weakSelf.navigationController pushViewController:settingVC animated:YES];

            
        };
        
        _headerView.didMyCollectBtnBlock = ^(YLMerchantOrArtificerIdType type) {
            
            if ([UserModelSisingle userId].length <= 0) {
                YLLoginController* loginVC = [YLLoginController new];
                loginVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:loginVC animated:YES];
                return ;
            }
            
            
            
            switch (type) {
                case YLMerchantOrArtificerIdTypeMerchant:
                    {
                        YLMerchantController* merchantVC = [YLMerchantController new];
                        merchantVC.type = MerchantControllerTypeMyCollect;
                        [weakSelf.navigationController pushViewController:merchantVC animated:YES];
                    }
                    break;
                case YLMerchantOrArtificerTypeArtificer:
                {
                    YLTechnicianController* technicianVC = [YLTechnicianController new];
                    technicianVC.isCollect = YES;
                    [weakSelf.navigationController pushViewController:technicianVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        };
        
    }
    return _headerView;
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
    HGSetUpSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HGSetUpSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    YLCenterModel* model = self.dataList[indexPath.section];
    cell.model = model;
    return cell;
}


#pragma mark -@protocol UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?8.f:0.5f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    YLCenterModel* model = self.dataList[indexPath.section];

    if ([model.title isEqualToString:@"商检入驻"]) {
        
        NSString *path=[[NSBundle mainBundle] pathForResource:@"tenants" ofType:@"html"];
        NSURL *url = [NSURL fileURLWithPath:path];
        YLOrderDealsController* orderVC = [YLOrderDealsController new];
        orderVC.urlString = [url absoluteString] ;
        [self.navigationController pushViewController:orderVC animated:YES];
        
    }else if ([model.title isEqualToString:@"会员中心"]){
        
        if ([UserModelSisingle userId].length <= 0) {
            YLLoginController* loginVC = [YLLoginController new];
            loginVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:loginVC animated:YES];
            return ;
        }
        
        YLMemberCenterController* centeVC = [YLMemberCenterController new];
        [self.navigationController pushViewController:centeVC animated:YES];
    }
    
}

WYGetter_MutableArray(dataList)
-(void)setCenterData{
    [[YLCenterVM sharedYLCenterVM] getCenterDataBlock:^(NSArray * _Nonnull block) {
        [self.dataList addObjectsFromArray:[YLCenterModel mj_objectArrayWithKeyValuesArray:block]];
        [self.tableView reloadData];
    }];
    
}


@end
