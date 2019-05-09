//
//  YLMemberCenterController.m
//  YPTuan
//
//  Created by gd on 2018/12/27.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMemberCenterController.h"
#import "YLMemberCenterCell.h"
@interface YLMemberCenterController ()

@property (nonatomic,strong) NSMutableArray *dataList;

@end

@implementation YLMemberCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 0, 0, 0));
    
    self.customTitle =@"会员中心";
    
    [self loadData];
}

#pragma mark -- tableViewDelegete --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return self.dataList.count;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        static NSString *identify = @"CenterCell";
        
        YLMemberCenterCell* cell = [tableView dequeueReusableCellWithIdentifier:identify ];
        if (!cell) {
            cell = [[YLMemberCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        
        cell.centerModel = self.dataList[indexPath.row];
        return cell;
    }
    
    
    
    static NSString *identify = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        
    }
    
    cell.textLabel.text = @"支付宝";
    
    
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
    return 8.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?1.f:0.5f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

WYGetter_MutableArray(dataList)

-(void)loadData{
    NSArray* dataArr = @[
                         @{@"timeLength":@"12个月",@"oldPrice":@"¥108元",@"currentPrice":@"¥98元"},
                         @{@"timeLength":@"3个月",@"oldPrice":@"¥68元",@"currentPrice":@"¥58元"},
                         @{@"timeLength":@"3个月",@"oldPrice":@"¥28元",@"currentPrice":@"¥18元"},
                         
                         ];
    
    self.dataList  = [YLMemberCenterModel mj_objectArrayWithKeyValuesArray:dataArr];
}

@end


@implementation YLMemberCenterModel



@end
