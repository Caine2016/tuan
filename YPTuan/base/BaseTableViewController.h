//
//  BaseTableViewController.h
//  buddhismYDniu
//
//  Created by longchenghua on 2017/9/22.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTableViewController : BaseVC<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
///分页大小
@property (nonatomic, assign) NSInteger pageSize;
///当前页 （默认1）
@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic,assign) BOOL isLoading;

/**结束刷新*/
- (void)endRefreshing;
/**开始刷新*/
- (void)beginRefreshing;
/**刷新初始化*/
- (void)loadData;

/**是否显示加载按钮*/
- (void)showLoadMoreControl:(BOOL)show;
/**是否显示下拉*/
-(void) showHeaderRefresh:(BOOL)show;

-(void)headerRefresh;
@end
