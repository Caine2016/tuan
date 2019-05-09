//
//  HGFineController.m
//  YPTuan
//
//  Created by Caine on 2018/7/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "HGFineController.h"
#import "SDCycleScrollView.h"
#import "YLLabHeaderView.h"
#import "GDGalleryBuddhaCollectionView.h"
#import "WaterflowView.h"
#import "YLBeautyShowView.h"
#import "YLTechnicianModel.h"
#import "YLTechnicianController.h"
@interface HGFineController ()<SDCycleScrollViewDelegate,WaterflowViewDataSource,WaterflowViewDelegate>

@property (nonatomic,strong) YLLabHeaderView *cycleHeaerView;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong) GDGalleryBuddhaCollectionView *interestsView;
@property (nonatomic,strong) YLLabHeaderView *interestsHeaderView;
@property (nonatomic,strong) YLLabHeaderView *waterflowViewHeaderView;


@property (nonatomic,strong) WaterflowView* waterflowView;

@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,strong) UIView *headerView;


@property (nonatomic,strong) LOTAnimationView *lottieLogo;

@end

@implementation HGFineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"精选";
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 0, 0, 0));
    
    
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.cycleHeaerView.height+self.cycleScrollView.height+5+self.interestsView.height+self.interestsHeaderView.height)];
    headerView.backgroundColor = KVCBGWhiteColor;
    [headerView sd_addSubviews:@[self.cycleScrollView,self.cycleHeaerView,self.interestsHeaderView,self.interestsView]];
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    [self.dataList addObjectsFromArray:[self getData]];
    [self.waterflowView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
          [self launchAnimation];
    });
    
  
}
#pragma mark - Private Methods
- (void)launchAnimation {
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    launchView.backgroundColor = KVCBGWhiteColor;
    
    
    [launchView addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(100, 0, 100, 0));
    [self.lottieLogo play];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:3.f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.0f, 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
        [self.lottieLogo stop];
    }];
}


-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"launchAM"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

-(YLLabHeaderView *)cycleHeaerView{
    if (!_cycleHeaerView) {
        _cycleHeaerView = [[YLLabHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleLabHeaderH+subLabHeaderTitleH) andTitle:@"本周好店" andSubTitle:@"全方位为你推荐,每天都有新惊喜" andRightTitle:nil];
    }
    return _cycleHeaerView;
}

-(YLLabHeaderView *)interestsHeaderView{
    if (!_interestsHeaderView) {
        _interestsHeaderView = [[YLLabHeaderView alloc] initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, kScreenWidth, titleLabHeaderH+subLabHeaderTitleH) andTitle:@"会员优惠" andSubTitle:@"VIP专属特权,我们不一样" andRightTitle:nil];
    }
    return _interestsHeaderView;
}
-(GDGalleryBuddhaCollectionView *)interestsView{
    if (!_interestsView) {
        _interestsView = [[GDGalleryBuddhaCollectionView alloc] initWithFrame:CGRectMake(0, self.interestsHeaderView.bottom, kScreenWidth, GalleryCollectionHeight)];
        _interestsView.dataArr = @[@"cell1",@"cell2",@"cell1",@"cell2",@"cell1",@"cell2"];
        WS(weakSelf);
        _interestsView.didSelectBuddhaImage = ^(NSInteger index) {
          //  weakSelf.selectBuddhaImageIndex = index + 1;
        };
        
    }
    return _interestsView;
}
- (SDCycleScrollView*)cycleScrollView
{
    if (_cycleScrollView) return _cycleScrollView;
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10,self.cycleHeaerView.bottom+5, kScreenWidth-20,450*(kScreenWidth/1080)) shouldInfiniteLoop:YES imageNamesGroup:nil];
    _cycleScrollView.backgroundColor = kClearColor;
    _cycleScrollView.delegate = self;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"gd_home_noImage"];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleScrollView.autoScrollTimeInterval = 4.0;
    _cycleScrollView.localizationImageNamesGroup = @[@"zen_sanzuo",@"zen_shuangzuo"];
    [_cycleScrollView hyb_addCornerRadius:BaseCornerRadius];
    return _cycleScrollView;
}

-(YLLabHeaderView *)waterflowViewHeaderView{
    if (!_waterflowViewHeaderView) {
        _waterflowViewHeaderView = [[YLLabHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleLabHeaderH+subLabHeaderTitleH) andTitle:@"猜你喜欢" andSubTitle:@"总有你喜欢的" andRightTitle:@"查看更多"];
        _waterflowViewHeaderView.backgroundColor = KVCBGWhiteColor;
        WS(weakSelf);
        _waterflowViewHeaderView.didMoreBlock = ^{
            YLTechnicianController* technicianVC = [YLTechnicianController new];
            [weakSelf.navigationController pushViewController:technicianVC animated:YES];
        };
    }
    return _waterflowViewHeaderView;
}

-(WaterflowView*)waterflowView
{
    if (!_waterflowView) {
        // 0.初始化数据
//        NSArray *newShops = [HMShopModel objectArrayWithFilename:@"2.plist"];
       
        _waterflowView = [[WaterflowView alloc] init];
        _waterflowView.dataSource = self;
        _waterflowView.delegate = self;
        _waterflowView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-kBaseTopHeight-(titleLabHeaderH+subLabHeaderTitleH));
        _waterflowView.backgroundColor = KVCBGWhiteColor;
//        [_waterflowView reloadData];
//        [_waterflowView addHeaderWithTarget:self action:@selector(loadNewShops)];
//        [_waterflowView addFooterWithTarget:self action:@selector(loadMoreShops)];
        
    }
    return _waterflowView;
}

-(NSArray*)getData{
    NSArray* date = @[
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                      @{@"commentCount":@(1000),@"likeCount":@(13415),@"imgName":@"meinv.com"},
                     
                      ];
    NSArray* list = [YLTechnicianModel mj_objectArrayWithKeyValuesArray:date];
    return list;
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
    cell.model = self.dataList[index];
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
    NSLog(@"点击了%lu",(unsigned long)index);
}

WYGetter_MutableArray(dataList)


#pragma mark -- tableViewDelegete --

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cells";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        
    }
    [cell.contentView addSubview:self.waterflowView];
    
    
    return cell;
}

#pragma mark -@protocol UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.waterflowViewHeaderView;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?(titleLabHeaderH+subLabHeaderTitleH):0.5f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScreenHeight-kBaseTopHeight-(titleLabHeaderH+subLabHeaderTitleH);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
