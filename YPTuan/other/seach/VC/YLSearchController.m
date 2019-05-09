//
//  YLSearchController.m
//  YPTuan
//
//  Created by gd on 2018/11/23.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLSearchController.h"
#import "GDSearchView.h"
#import "KMTagListView.h"
#import "GDSearchHeaderView.h"
@interface YLSearchController ()<KMTagListViewDelegate>
@property (nonatomic,strong) GDSearchView *searchView;
@property (nonatomic,strong ) KMTagListView    *tagListView;
@property (nonatomic,strong) LOTAnimationView *lottieLogo;
@property (nonatomic,copy) NSString *textContent;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) UIView *bgView;
@end

@implementation YLSearchController
WYGetter_MutableArray(dataArr)
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.myNavBarView addSubview:self.searchView];
    [self.myNavBarView bringSubviewToFront:self.rightButton];
    self.backButton.hidden = YES;
    [self createRightButton: @"取消" imageName:nil selector:@selector(backAction)];
    
    [self.view addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight+kBaseTopHeight, 30, kBaseTopHeight, 30));
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 0, 0, 0));
    
    self.tableView.mj_header.hidden = YES;
    self.tableView.mj_footer.hidden = YES;
    
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入加载状态后会自动调用这个block
        if (self.textContent.length <= 0) {
            [ShowHUD showWarn:@"请输入搜索内容"];
            self.tableView.mj_footer.state = MJRefreshStateIdle;
            return;
        }
        
        self.pageIndex ++;
        
     //   [self loadData:self.textContent];
    }];
    
    self.pageIndex = 1;
    [self creatHotView];
    [self.view addSubview:self.bgView];
   

}

-(void) creatHotView{
    NSMutableArray* tepArr = [NSMutableArray array];
    NSArray* result = @[@"天天开心",@"天天开心",@"天天开心",@"天天开心",@"天天开心",@"天天开心"];
//    for (int i =0; i < result.count; i++) {
//        [tepArr addObject:result[i][@"KeyWords"]];
//
//    }
    [tepArr addObjectsFromArray:result];
    GDSearchHeaderView* headerView   = [[GDSearchHeaderView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth, 44)];
    headerView.title                 = @"搜索历史";
    [self.tagListView setupSubViewsWithTitles:tepArr];
    
    CGRect rect                      = self.tagListView.frame;
    rect.size.height                 = 125;
    self.tagListView.frame           = rect;
    UIView* bgView                   = [[UIView alloc] initWithFrame:CGRectMake(0, kBaseTopHeight, kScreenWidth, headerView.height+self.tagListView.height)];
    [bgView addSubview:self.tagListView];
    [bgView addSubview:headerView];
    bgView.backgroundColor           = VCBGColor;
    self.tagListView.backgroundColor = VCBGColor;
    self.bgView = bgView;
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}

-(KMTagListView *)tagListView{
    if (!_tagListView) {
        _tagListView = [[KMTagListView alloc]initWithFrame:CGRectMake(0, 46, self.view.frame.size.width, 0)];
        _tagListView.delegate_ = self;
        
    }
    
    return _tagListView;
}

-(GDSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[GDSearchView alloc] initWithFrame:self.myNavBarView.frame];
        WS(weakSelf);
        _searchView.searchViewBlock = ^(NSString *textFiledText) {
            
            weakSelf.textContent = textFiledText;
            
        //    [weakSelf loadData:textFiledText];
            
        };
        
        _searchView.textChangeActionBlock = ^(NSString *textFiledText) {
            
            
            CNSLog(@"text==%@",textFiledText);
            
            if (textFiledText.length >= 60) {
                [ShowHUD showWarn: NSLocalizedString(@"TopicsLess60", nil)];
                return ;
            }
            
            if (textFiledText.length > 0) {
             //   weakSelf.content = [NSString stringWithFormat:@"%@:#%@#",NSLocalizedString(@"NewTopics", nil),textFiledText];
            }else{
              //  weakSelf.content = @"";
            }
            
            weakSelf.textContent = textFiledText;
            
            [weakSelf.tableView reloadData];
            
            
        };
        
    }
    return _searchView;
}

-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"empty_box"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

#pragma mark - //热词点击
- (void)ptl_TagListView:(KMTagListView *)tagListView didSelectTagViewAtIndex:(NSInteger)index selectContent:(NSString *)content {
    

    
    //XLog(@"content: %@ index: %ld", content, (long)index);
}

#pragma mark -@protocol UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
 
    return self.dataArr.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *rid=@"topicsCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    
    return cell;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
    return 85;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 1.f;
    
}
#pragma mark -@protocol UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
