//
//  YLShopDetailsController.m
//  YPTuan
//
//  Created by gd on 2018/11/26.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLShopDetailsController.h"

#import "SDCycleScrollView.h"
#import "YLShopDetailsView.h"
#import "YLPreferentialCell.h"
#import "YPVouchersView.h"
#import "YLLabLeftImgBackView.h"
#import "YLTechnicianController.h"
#import "YLCommentViewController.h"

#import "SDTimeLineCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"

#import "YLHaveFunVm.h"

#import "YLPushCommentViewController.h"
#import "EvaluateViewController.h"

#import "YLShopCommentModel.h"
#import "YLMerchantImagesModel.h"

#define kTimeLineTableViewCellId @"SDTimeLineCell"


#define SectionHerderHerght 40
@interface YLShopDetailsController ()<SDCycleScrollViewDelegate,SDTimeLineCellDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView; //商店轮播图片
@property (nonatomic,strong) YLShopDetailsView *shopDetailsView; //商店信息
@property (nonatomic,strong) YPVouchersView *technicianView; //技师介绍
@property (nonatomic,strong) YLLabLeftImgBackView *moreTechniceanView;//更多技师
@property (nonatomic,strong) YLLabLeftImgBackView *moreCommentView;//更多评论


@property (nonatomic,strong) NSMutableArray *dataList; //评论

@property (nonatomic,strong) UILabel *preferentialHeaderView;//优惠信息
@property (nonatomic,strong) UILabel *technicianHeaderView;  //技师介绍
@property (nonatomic,strong) UILabel *commentsHeaderView;  //技师介绍

@property (nonatomic,strong) UIButton *commentBtn;  //评论

///收藏成功动画
@property (nonatomic,strong) LOTAnimationView *lottieLogo;


@end

@implementation YLShopDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.myNavBarView.hidden = YES;
    self.myNavBarView.backgroundColor = kClearColor;
    self.bottomLineView.hidden = YES;
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    
    self.tableView.tableHeaderView = self.cycleScrollView;
    
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
 
    [self addData];
    
    [GDNotificationCenter addObserver:self selector:@selector(addCommentData) name:CommentSuccessBack object:nil];

}

-(void)addData{
    ///轮播图片
    [self addHeaderData];
    
    ///评论
    [self addCommentData];
    [self addArtificerData];
    ///技师
    
    //评论桩体
    [self getCollectState];
    
}
-(void)dealloc{
    [GDNotificationCenter removeObserver:self name:CommentSuccessBack object:nil];
}
#pragma mark -- data --
-(void) addArtificerData{
    
    [[YLHaveFunVm sharedYLHaveFunVm] getArrificerByPageindex:1 andPagesize:4 andMerchantId:self.dealsModel.merchantId andArrificerData:^(NSArray *data,NSInteger total) {
        
        self.technicianView.data = data;
        [self.tableView reloadData];

    }];
    
}

-(void)addCommentData{
    [[YLHaveFunVm sharedYLHaveFunVm] getShopCommentByPageindex:1 andPagesize:3 andMerchantId:self.dealsModel.merchantId andShopData:^(NSDictionary *data) {
        
        NSArray* result = data[@"records"];
        
        [self.dataList addObjectsFromArray:[YLShopCommentModel mj_objectArrayWithKeyValuesArray:result]];
        
        [self.tableView reloadData];
    }];
}
-(void)addHeaderData{
    NSMutableArray *imageURLStringsGroups = [NSMutableArray array];

    [self.dealsModel.merchantImages enumerateObjectsUsingBlock:^(YLMerchantImagesModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.imageType == YLMerchantOrArtificerImageTypeShow) {
            
            [imageURLStringsGroups addObject:obj.compressionImageUrl?:@""];
        }
        
    }];
    self.cycleScrollView.imageURLStringsGroup = imageURLStringsGroups;
}
-(void)getCollectState{
    
    if (UserModelSisingle.userId.length <= 0) return;
    
    [[YLHaveFunVm sharedYLHaveFunVm] colloctStatusMerchantOrArtificerId:self.dealsModel.merchantId userName:UserModelSisingle.userName andType:YLMerchantOrArtificerIdTypeMerchant andReturnData:^(BOOL isCollect) {
        self.rightButton.selected = isCollect;
    }];
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
    
    [[YLHaveFunVm sharedYLHaveFunVm] colloctMerchantOrArtificerId:self.dealsModel.merchantId userName:UserModelSisingle.userName andType:YLMerchantOrArtificerIdTypeMerchant andReturnData:^(NSDictionary *data) {
       
        [self.view addSubview:self.lottieLogo];
        self.lottieLogo.sd_layout
        .centerXEqualToView(self.view)
        .centerYEqualToView(self.view)
        .heightIs(200)
        .widthEqualToHeight();
        
     //   [self.lottieLogo play];

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
    commentVC.dealsModel = self.dealsModel;
    commentVC.type = YLMerchantOrArtificerIdTypeMerchant;
    [self.navigationController pushViewController:commentVC animated:YES];
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

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithFrame:CGRectZero normalBackgroundImage:[XTools imageWithColor:kColorLogin] target:self action:@selector(commentAction)];
        [_commentBtn setTitle:@"指点江山" forState:UIControlStateNormal];
        
    }
    return _commentBtn;
}

-(UILabel *)commentsHeaderView{
    if (!_commentsHeaderView) {
        _commentsHeaderView = [UILabel labelWithFrame:CGRectMake(0, 0, kScreenWidth, SectionHerderHerght) textColor:MainBackColor font:HNW3Font(18) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
        _commentsHeaderView.text = @"  网友点评";
        _commentsHeaderView.backgroundColor = KVCBGWhiteColor;
        [_commentsHeaderView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, SectionHerderHerght) andLineToPoint:CGPointMake(kScreenWidth-BaseBtnPadding*2, SectionHerderHerght)]];
    }
    return _commentsHeaderView;
}

-(UILabel *)technicianHeaderView{
    if (!_technicianHeaderView) {
        _technicianHeaderView = [UILabel labelWithFrame:CGRectMake(0, 0, kScreenWidth, SectionHerderHerght) textColor:MainBackColor font:HNW3Font(18) numberOfLines:1 lineBreakMode:0 lineAlignment:NSTextAlignmentLeft];
        _technicianHeaderView.text = @"  技师介绍";
        _technicianHeaderView.backgroundColor = KVCBGWhiteColor;
        [_technicianHeaderView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, SectionHerderHerght) andLineToPoint:CGPointMake(kScreenWidth-BaseBtnPadding*2, SectionHerderHerght)]];
    }
    return _technicianHeaderView;
}

-(UILabel *)preferentialHeaderView{
    if (!_preferentialHeaderView) {
        
        _preferentialHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SectionHerderHerght)];
        _preferentialHeaderView.font = HNW3Font(18);
        _preferentialHeaderView.text = @"  优惠信息";
        _preferentialHeaderView.backgroundColor = KVCBGWhiteColor;
        
        [_preferentialHeaderView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, SectionHerderHerght) andLineToPoint:CGPointMake(kScreenWidth-BaseBtnPadding*2, SectionHerderHerght)]];
    }
    return _preferentialHeaderView;
}

-(YPVouchersView *)technicianView{
    if (!_technicianView) {
        CGFloat technicianViewItemWidth = (kScreenWidth - BaseBtnPadding*3)/2;
         _technicianView = [[YPVouchersView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth, TechnicianCellHeight*2+BaseBtnPadding*2+5) andItemSize:CGSizeMake(technicianViewItemWidth, TechnicianCellHeight) andFlowInset:UIEdgeInsetsMake(0, BaseBtnPadding,0, BaseBtnPadding) andType:VouchersViewTypeTechnician andInteritemSpacing:BaseBtnPadding andlineSpacing:BaseBtnPadding];
        
       
    }
    return _technicianView;
}
-(YLLabLeftImgBackView *)moreCommentView{
    if (!_moreCommentView) {
        _moreCommentView = [YLLabLeftImgBackView new ];
        _moreCommentView.title = @"查看更多评论";
        [_moreCommentView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, 0) andLineToPoint:CGPointMake(kScreenWidth-BaseBtnPadding*2, 0)]];
        WS(weakSelf);
        _moreCommentView.didLabLeftImgBackViewBlock = ^{
            YLCommentViewController* commentVC = [YLCommentViewController new];
            commentVC.dealsModel = weakSelf.dealsModel;
            [weakSelf.navigationController pushViewController:commentVC animated:YES];
        };
        
    }
    return _moreCommentView;
}
-(YLLabLeftImgBackView *)moreTechniceanView{
    if (!_moreTechniceanView) {
        _moreTechniceanView = [YLLabLeftImgBackView new];
        _moreTechniceanView.title = @"查看更多技师";
         [_moreTechniceanView.layer addSublayer:[GDTool solidShapeLayer:COLOR_ededed andMoveToPoint:CGPointMake(BaseBtnPadding, 0) andLineToPoint:CGPointMake(kScreenWidth-BaseBtnPadding*2, 0)]];
        WS(weakSelf);
        _moreTechniceanView.didLabLeftImgBackViewBlock = ^{
            YLTechnicianController* technicianVC = [YLTechnicianController new];
            technicianVC.merchantId = weakSelf.dealsModel.merchantId;
            [weakSelf.navigationController pushViewController:technicianVC animated:YES];
        };
        
    }
    return _moreTechniceanView;
}

- (SDCycleScrollView*)cycleScrollView
{
    if (_cycleScrollView) return _cycleScrollView;
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0,0, kScreenWidth,kScreenHeight/4*1) shouldInfiniteLoop:YES imageNamesGroup:nil];
    _cycleScrollView.backgroundColor = kClearColor;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:DefaultImageImage];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleScrollView.autoScrollTimeInterval = 4.0;
  //  _cycleScrollView.localizationImageNamesGroup = @[@"zen_sanzuo",@"zen_shuangzuo"];
    return _cycleScrollView;
}

-(YLShopDetailsView *)shopDetailsView{
    if (!_shopDetailsView) {
        _shopDetailsView = [YLShopDetailsView new];
        _shopDetailsView.model = self.dealsModel;
    }
    return _shopDetailsView;
}




#pragma mark -- tableViewDelegete --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 1:
            return 2;
            break;
        case 3:
            return self.dataList.count;
            break;
        default:
            break;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cells";
    
    if (indexPath.section == 3) {
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
    
    if (indexPath.section == 1) {
        static NSString *rid = @"YLPreferentialCell";
        
        YLPreferentialCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[YLPreferentialCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        return cell;

    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];

    }
    
    switch (indexPath.section) {
        case 0:{
            [cell.contentView addSubview:self.shopDetailsView];
            self.shopDetailsView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
            break;
        case 2:{
            [cell.contentView addSubview:self.technicianView];
            self.technicianView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, BaseBtnHeight44, 0));
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.contentView addSubview:self.moreTechniceanView];
            self.moreTechniceanView.sd_layout
            .topSpaceToView(self.technicianView, 4)
            .leftEqualToView(cell.contentView)
            .rightEqualToView(cell.contentView)
            .heightIs(40);
        }
            break;

            
        default:
            break;
    }
    
    
    
    return cell;
}

#pragma mark -@protocol UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section == 3) {
        UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BaseBtnHeight44)];
        [view addSubview:self.moreCommentView];
        self.moreCommentView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        return view;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return self.preferentialHeaderView;
            break;
        case 2:
            return self.technicianHeaderView;
            break;
        case 3:
            return self.commentsHeaderView;
            break;
            
            
        default:
            break;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 3 ? BaseBtnHeight44 : BaseBtnPadding;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ?1.f:SectionHerderHerght;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return ShopDetailsViewHeight;
            break;
        case 1:
            return PreferentialCellHeight;
            break;
        case 2:
            return TechnicianCellHeight*2+BaseBtnPadding*2+BaseBtnHeight44;
            break;
        case 3:{
            // >>>>>>>>>>>>>>>>>>>>> * cell自适应 * >>>>>>>>>>>>>>>>>>>>>>>>
            YLShopCommentModel* shopCommentModel = self.dataList[indexPath.row];
            return [self.tableView cellHeightForIndexPath:indexPath model:shopCommentModel keyPath:@"shopCommentModel" cellClass:[SDTimeLineCell class] contentViewWidth:kScreenWidth];
            
        }
            
        default:
            return 64;
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

WYGetter_MutableArray(dataList)

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
@end
