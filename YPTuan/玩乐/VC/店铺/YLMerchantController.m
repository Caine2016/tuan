//
//  YLMerchantController.m
//  YPTuan
//
//  Created by gd on 2018/12/17.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMerchantController.h"

@interface YLMerchantController ()
@property (nonatomic,strong) LOTAnimationView *lottieLogo;

@end

@implementation YLMerchantController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"店铺收藏";
    
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 30, kBaseTopHeight, 30));
    [self setSuperVC];
    
    self.isLoading = NO;
    self.pageIndex = 1;
    [self addData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.lottieLogo stop];
}

-(void)setSuperVC{
    
    self.tableView.height = SCREEN_HEIGHT - kBaseTopHeight;
 
    self.tableView.mj_header = [YLMJRefreshLottioHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    
    self.tableView.mj_footer.hidden = NO;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            if (self.isLoading) return ;
            self.isLoading = YES;
            self.pageIndex ++;
            [self addData];
        }];
    
    self.tableView.tableHeaderView = nil;
    self.sectionTitleLab.text = @"";
    [self.sectionTitleLab removeFromSuperview];
    [self.seachV removeFromSuperview];
    [self.typeView removeFromSuperview];

}

-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"empty_data"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}
#pragma mark --data --

-(void)headerRefresh{
    if (self.isLoading) return ;
    self.isLoading = YES;
    self.pageIndex = 1;
    [self addData];
}
-(void)addData{
    
    [[YLHaveFunVm sharedYLHaveFunVm] getMyCollectByPageindex:self.pageIndex andPagesize:self.pageSize andUsername:UserModelSisingle.userName andType:YLMerchantOrArtificerIdTypeMerchant andCollectData:^(NSArray *data, NSInteger totle) {
        
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
#pragma mark ---tableView delegate --



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.f;
}

@end
