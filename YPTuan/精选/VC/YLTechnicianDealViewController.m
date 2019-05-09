//
//  YLTechnicianDealViewController.m
//  YPTuan
//
//  Created by Caine on 2018/12/13.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLTechnicianDealViewController.h"
#import "SDCycleScrollView.h"
#import "EvaluateViewController.h"

#import "SDTimeLineCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

#import "YLHaveFunVm.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"
#define CycleScrollViewHeight kScreenHeight/4*1


@interface YLTechnicianDealViewController ()<SDCycleScrollViewDelegate,SDTimeLineCellDelegate>
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //轮播图片

@property (nonatomic,strong) UIButton *commentBtn;  //评论
///收藏成功动画
@property (nonatomic,strong) LOTAnimationView *lottieLogo;

///无评论动画
@property (nonatomic,strong) LOTAnimationView *commentLottieLogo;

@property (nonatomic,strong) NSMutableArray *dataList;


@end

@implementation YLTechnicianDealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myNavBarView.backgroundColor = kClearColor;
    self.bottomLineView.hidden = YES;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    self.tableView.tableHeaderView = self.cycleScrollView;
    
    [self.view addSubview:self.commentLottieLogo];
    self.commentLottieLogo.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .heightIs(250)
    .widthEqualToHeight();
    
    [self createRightButton:nil imageName:@"noCollectBtn" selector:@selector(collectAction)];
    [self.rightButton setImage:IMAGENAME(@"collectBtn") forState:UIControlStateSelected];
    
    
    [self.view bringSubviewToFront:self.myNavBarView];
    
    [self.tableView registerClass:[SDTimeLineCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
    [self.view addSubview:self.commentBtn];
    self.commentBtn.sd_layout
    .bottomEqualToView(self.view)
    .rightEqualToView(self.view)
    .leftEqualToView(self.view)
    .heightIs(BaseBtnHeight49);

    self.pageSize = 20;
    self.pageIndex = 1;
    self.isLoading = NO;
    
    self.tableView.mj_header = [YLMJRefreshLottioHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.isLoading) return ;
        self.isLoading = YES;
        self.pageIndex ++;
        [self loadData];
    }];

    [self addHeaderData];
    [self loadData];
    if (UserModelSisingle.userId.length > 0) {
         [self getCollectState];
    }
   
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.commentLottieLogo pause];
}
#pragma mark -- data --
-(void)headerRefresh{
    if (self.isLoading) return ;
    self.isLoading = YES;
    self.pageIndex = 1;
    [self loadData];
}

-(void)getCollectState{
    [[YLHaveFunVm sharedYLHaveFunVm] colloctStatusMerchantOrArtificerId:self.artificerModel.artificerId userName:UserModelSisingle.userName andType:YLMerchantOrArtificerTypeArtificer andReturnData:^(BOOL isCollect) {
        self.rightButton.selected = isCollect;
    }];
}

-(void)loadData{
    [[YLHaveFunVm sharedYLHaveFunVm] getArtificerCommentByPageindex:self.pageIndex andPagesize:self.pageSize andArtificerId:self.artificerModel.artificerId andArtificerData:^(NSArray *data, NSInteger total) {
        
        self.isLoading = NO;
        if (self.pageIndex == 1) {
            self.tableView.mj_header.state = MJRefreshStateIdle;
            [self.dataList removeAllObjects];
        }
        NLog(@"data %lu",(unsigned long)data.count);
        [self.dataList addObjectsFromArray:data];
        
        if (self.dataList.count >= total) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
        if (self.dataList.count > 0) {
            self.tableView.mj_footer.hidden = NO;
            self.tableView.mj_header.hidden = NO;
             self.commentLottieLogo.hidden = YES;
             [self.commentLottieLogo pause];
        }else{
            self.tableView.mj_footer.hidden = YES;
            self.tableView.mj_header.hidden = YES;

            self.commentLottieLogo.hidden = NO;
            [self.commentLottieLogo play];
        }
        
        [self.tableView reloadData];
        
    }];
}

-(void)addHeaderData{
    NSMutableArray *imageURLStringsGroups = [NSMutableArray array];
    
    [self.artificerModel.bizMerchantArtificerImages enumerateObjectsUsingBlock:^(YLMerchantImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.imageType == YLMerchantOrArtificerImageTypeShow) {
            
            [imageURLStringsGroups addObject:obj.compressionImageUrl?:@""];
        }
        
    }];
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroups;
}

#pragma mark -- view --

-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"love_explosion"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        // _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

-(LOTAnimationView *)commentLottieLogo{
    if (!_commentLottieLogo) {
        _commentLottieLogo = [LOTAnimationView animationNamed:@"empty_status"];
        _commentLottieLogo.contentMode = UIViewContentModeScaleAspectFill;
       _commentLottieLogo.loopAnimation = YES;
    }
    return _commentLottieLogo;
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithFrame:CGRectZero normalBackgroundImage:[XTools imageWithColor:kColorLogin] target:self action:@selector(commentAction)];
        [_commentBtn setTitle:@"指点江山" forState:UIControlStateNormal];
        
    }
    return _commentBtn;
}

- (SDCycleScrollView*)cycleScrollView
{
    if (_cycleScrollView) return _cycleScrollView;
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenWidth,CycleScrollViewHeight) shouldInfiniteLoop:YES imageNamesGroup:nil];
    _cycleScrollView.backgroundColor = kClearColor;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:DefaultImageImage];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleScrollView.autoScrollTimeInterval = 4.0;
    //  _cycleScrollView.localizationImageNamesGroup = @[@"zen_sanzuo",@"zen_shuangzuo"];
    return _cycleScrollView;
}

#pragma mark -- action --
///收藏
-(void)collectAction{
    
    if ([UserModelSisingle userId].length <= 0) {
        YLLoginController* loginVC = [YLLoginController new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        return ;
    }
    
    [[YLHaveFunVm sharedYLHaveFunVm] colloctMerchantOrArtificerId:self.artificerModel.artificerId userName:UserModelSisingle.userName andType:YLMerchantOrArtificerTypeArtificer andReturnData:^(NSDictionary *data) {
        
        [self.view addSubview:self.lottieLogo];
        self.lottieLogo.sd_layout
        .centerXEqualToView(self.view)
        .centerYEqualToView(self.view)
        .heightIs(200)
        .widthEqualToHeight();
        
        
        
        [self.lottieLogo playWithCompletion:^(BOOL animationFinished) {
            self.rightButton.selected = YES;
            CATransform3D currentTransform = self.lottieLogo.layer.transform;
            [UIView animateWithDuration:.8f delay:0.0 options:UIViewAnimationOptionTransitionNone
                             animations:^{
                                 self.lottieLogo.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(1.2f, 1.2f, 1.0));
                                 self.lottieLogo.layer.opacity = 0.0f;
                             }completion:^(BOOL finished) {
                                 [self.lottieLogo removeFromSuperview];
                             }
             ];
            
        }];
        
        
        
    }];
}

///评论
-(void)commentAction{
    
    if ([UserModelSisingle userId].length <= 0) {
        YLLoginController* loginVC = [YLLoginController new];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
        return ;
    }
    EvaluateViewController* commentVC = [EvaluateViewController new];
    commentVC.artificerModel = self.artificerModel;
    commentVC.type = YLMerchantOrArtificerTypeArtificer;
    [self.navigationController pushViewController:commentVC animated:YES];
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
  
        SDTimeLineCell *cell = [tableView dequeueReusableCellWithIdentifier:kTimeLineTableViewCellId];
        cell.indexPath = indexPath;
        __weak typeof(self) weakSelf = self;
        if (!cell.moreButtonClickedBlock) {
            [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
                YLShopCommentModel *model = weakSelf.dataList[indexPath.row];
                model.isOpening = !model.isOpening;
                [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }];
            
            cell.delegate = self;
       
        }
        ////// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅 //////
        
        [cell useCellFrameCacheWithIndexPath:indexPath tableView:tableView];
        
        ///////////////////////////////////////////////////////////////////////
        
        cell.shopCommentModel = self.dataList[indexPath.row];
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
    return  1.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1.f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
            // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
    YLShopCommentModel *shopCommentModel = self.dataList[indexPath.row];
     return [self.tableView cellHeightForIndexPath:indexPath model:shopCommentModel keyPath:@"shopCommentModel" cellClass:[SDTimeLineCell class] contentViewWidth:kScreenWidth];
            
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - SDTimeLineCellDelegate

- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell
{
    
    
}

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    //   YLMerchantImagesModel *model = self.dataList[index.row];
    
    //    NSMutableArray *temp = [NSMutableArray arrayWithArray:model.likeItemsArray];
    //
    //    if (!model.isLiked) {
    //        SDTimeLineCellLikeItemModel *likeModel = [SDTimeLineCellLikeItemModel new];
    //        likeModel.userName = @"GSD_iOS";
    //        likeModel.userId = @"gsdios";
    //        [temp addObject:likeModel];
    //        model.liked = YES;
    //    } else {
    //        SDTimeLineCellLikeItemModel *tempLikeModel = nil;
    //        for (SDTimeLineCellLikeItemModel *likeModel in model.likeItemsArray) {
    //            if ([likeModel.userId isEqualToString:@"gsdios"]) {
    //                tempLikeModel = likeModel;
    //                break;
    //            }
    //        }
    //        [temp removeObject:tempLikeModel];
    //        model.liked = NO;
    //    }
    //    model.likeItemsArray = [temp copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    });
}
#pragma mark --scrollViewdelage --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translatedPoint = [scrollView.panGestureRecognizer translationInView:scrollView];
    
    if(translatedPoint.y < 0)
        [self btnViewWillShow:YES];//上
    
    if(translatedPoint.y > 0)
        [self btnViewWillShow:NO];
    //下
    //同理通过translatedPoint.y 进行判断上下滑动
}

-(void) btnViewWillShow:(BOOL)isShow{
    [UIView animateWithDuration:.5f animations:^{
        isShow ? (self.commentBtn.mj_y = kScreenHeight) : (self.commentBtn.mj_y = kScreenHeight - BaseBtnHeight49);
    }];
}


WYGetter_MutableArray(dataList)

@end
