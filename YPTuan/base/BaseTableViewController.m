//
//  BaseTableViewController.m
//  buddhismYDniu
//
//  Created by longchenghua on 2017/9/22.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
- (instancetype)init{
    if (self = [super init]) {
        _pageIndex = 1;
        _pageSize = 10;
        _isLoading = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
 
    
}
/**开始刷新*/
- (void)beginRefreshing{
    [self.tableView.mj_header beginRefreshing];
}
/**结束刷新*/
- (void)endRefreshing{
    [self.view endEditing:YES];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
- (void)loadData{}

-(void)headerRefresh{
    if (self.isLoading) return ;
    self.isLoading = YES;
    self.pageIndex = 1;
    [self loadData];
}

-(void) showHeaderRefresh:(BOOL)show{
    if (show) {
        self.tableView.mj_header = [YLMJRefreshLottioHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        
    }else{
        self.tableView.mj_header.hidden = YES;
    }
}

/**是否显示加载按钮*/
- (void)showLoadMoreControl:(BOOL)show{
    if (show){
   
        WS(weakSelf)
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (weakSelf.isLoading) return ;
            weakSelf.isLoading = YES;
            weakSelf.pageIndex ++;
            [weakSelf loadData];
        }];
        //  }
    }else{
        if (_tableView.mj_footer){
            _tableView.mj_footer.hidden = YES;
            //[_tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }
}
#pragma mark -- UITableViewDataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
     return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UITableView*)tableView{
    if (_tableView) return _tableView;
    _tableView                                = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.backgroundColor                = VCBGColor;
    _tableView.delegate                       = self;
    _tableView.dataSource                     = self;
    _tableView.separatorStyle                 = UITableViewCellSeparatorStyleNone;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator   = NO;
    _tableView.estimatedRowHeight             = 0;
    _tableView.estimatedSectionHeaderHeight   = 0;
    _tableView.estimatedSectionFooterHeight   = 0;
    if (@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _tableView;
}

@end
