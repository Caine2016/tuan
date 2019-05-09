//
//  YLSettingController.m
//  YPTuan
//
//  Created by gd on 2018/11/18.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLSettingController.h"
#import "YLCenterVM.h"
#import "YLCenterModel.h"
#import "HGSetUpSelectCell.h"
#import "YLChagePwdController.h"
#import "YLCenterVM.h"
#import "FeedBackVC.h"
@interface YLSettingController ()
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) UIButton *logOutBtn;
@end

@implementation YLSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"设置";
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 0, 0, 0 ));
    [self setSettingData];
    
    
    if ([UserModelSisingle userId].length > 0) {
        UIView* footerView = [UIView new];
        self.tableView.tableFooterView = footerView;
        footerView.sd_layout
        .topEqualToView(self.tableView)
        .leftEqualToView(self.tableView)
        .rightEqualToView(self.tableView)
        .heightIs(BaseBtnHeight49+30);
        
        [footerView addSubview:self.logOutBtn];
        self.logOutBtn.sd_layout
        .topSpaceToView(footerView, 30)
        .leftSpaceToView(footerView, 15)
        .rightSpaceToView(footerView, 15)
        .heightIs(BaseBtnHeight49);
    }
    
    
 
    
}

-(UIButton *)logOutBtn{
    if (!_logOutBtn) {
       _logOutBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"退出登录" normalColor:KVCBGWhiteColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(logOutAction)];
        _logOutBtn.layer.masksToBounds = YES;
        _logOutBtn.backgroundColor = kColorLogin;
        _logOutBtn.layer.cornerRadius = BaseBtnHeight49/2;
    }
    return _logOutBtn;
}
#pragma mark --event --
-(void)logOutAction{
    
    NSString* userName = [[EGOCache globalCache] stringForKey:SaveIphoneLocality];
    if (!userName || userName.length <= 0) {
        return;
    }
    [BaseDataServiceSISingle delUrl:UserLogOutUrl andParamsDic:@{@"userName":userName} andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        [UserModelSisingle clearData];
        [GDNotificationCenter postNotificationName:LoginOrLogOutNotification object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
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
    if ([model.title isEqualToString:@"清除缓存"]) {
        model.righTitle = [[YLCenterVM sharedYLCenterVM] readCacheSize];
    }
    cell.model = self.dataList[indexPath.section];
    
    
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
    return (section == 0 || section == 1 || section == 2)?8.f:1.f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    YLCenterModel* model = self.dataList[indexPath.section];
    if ([model.title isEqualToString:@"修改密码"]) {
        YLChagePwdController* changePwdVC = [YLChagePwdController new];
        [self.navigationController pushViewController:changePwdVC animated:YES];
    }
    else if ([model.title isEqualToString:@"意见反馈"]){
        FeedBackVC* feedBackVC = [FeedBackVC new];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    else if ([model.title isEqualToString:@"清除缓存"]) {
        MyAlertController * alert = [MyAlertController alertControllerWithTitle:nil message:@"是否确定清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        
        MyAlertAction* sureBtn = [MyAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[YLCenterVM sharedYLCenterVM] clearFile];
            model.righTitle = [[YLCenterVM sharedYLCenterVM] readCacheSize];
            [ShowHUD showSuccessStatus:@"清除成功!"];
            //kTR_Message(@"已清理本地空间");
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        
        
        MyAlertAction* cancelBtn = [MyAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        alert.tintColor = MainBackColor;
        
        [alert addAction:sureBtn];
        
        [alert addAction:cancelBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

WYGetter_MutableArray(dataList)
-(void)setSettingData{
    [[YLCenterVM sharedYLCenterVM] getSettingDataBlock:^(NSArray * _Nonnull blockData) {
        
        [self.dataList addObjectsFromArray:[YLCenterModel mj_objectArrayWithKeyValuesArray:blockData]];
        [self.tableView reloadData];
    }];
    
}


@end
