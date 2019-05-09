//
//  YLCommentViewController.m
//  YPTuan
//
//  Created by gd on 2018/12/7.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLPushCommentViewController.h"
#import "XFCustomEView.h"
@interface YLPushCommentViewController ()
@property (nonatomic, strong) NSMutableArray <NSMutableArray *>* tagArray; /**< 标签数组 */
@property (nonatomic, strong) NSMutableArray * tagNameArray; /**< 标签名字数组 */
@property (nonatomic, strong) XFCustomEView * evalueTopBgView; /**< 顶部评价背景 */

@property (nonatomic,strong) UIButton *commentBtn;  //评论


@end

@implementation YLPushCommentViewController


//WYGetter_MutableArray(dataList)
WYGetter_MutableArray(tagArray)
//WYGetter_MutableArray(tagNameArray)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customTitle = @"评价";
    
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(kBaseTopHeight, 0,BaseBtnHeight49, 0));
    
     [self insertTopView];
    
    [self.view addSubview:self.commentBtn];
    self.commentBtn.sd_layout
    .bottomEqualToView(self.view)
    .rightEqualToView(self.view)
    .leftEqualToView(self.view)
    .heightIs(BaseBtnHeight49);
    
}


- (void)insertTopView{
    self.evalueTopBgView = [[XFCustomEView alloc] init];
    self.evalueTopBgView.titlesArr = self.tagNameArray[0];
    __weak typeof(self) weakSelf = self;
    self.evalueTopBgView.refreshView = ^(XFEvaluateRank *button) {
        weakSelf.evalueTopBgView.titlesArr = weakSelf.tagNameArray[(int)button.tag - 100];
        [weakSelf.evalueTopBgView addDymView];
        [weakSelf.tableView reloadData];
    };
    self.tableView.tableHeaderView = self.evalueTopBgView;
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithFrame:CGRectZero normalBackgroundImage:[XTools imageWithColor:kColorLogin] target:self action:@selector(submitCommentAction)];
        [_commentBtn setTitle:@"提交评论" forState:UIControlStateNormal];
        
    }
    return _commentBtn;
}


#pragma mark -- action --
-(void)submitCommentAction{
  
}
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
    return section == 0?1.f:0.5f;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



//
//-(NSMutableArray<NSMutableArray *> *)tagArray{
//    if (_tagArray == nil) {
//        _tagArray = [[NSMutableArray alloc] init];
//        [_tagArray addObject: [[NSMutableArray alloc] init]];
//        [_tagArray addObject: [[NSMutableArray alloc] init]];
//        [_tagArray addObject: [[NSMutableArray alloc] init]];
//        [_tagArray addObject: [[NSMutableArray alloc] init]];
//        [_tagArray addObject: [[NSMutableArray alloc] init]];
//    }
//    return _tagArray;
//}
-(NSMutableArray *)tagNameArray{
    if (_tagNameArray == nil) {
        _tagNameArray = [[NSMutableArray alloc] init];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"不是", @"一个糖"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"不是", @"一杯水"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"更不是", @"不是简简单单的甜言蜜语"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"而是", @"万里挑一的灵魂碰撞", @"有趣的灵魂总是俺么万里挑一", @"有趣的灵魂总是俺么万里挑一"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"我们", @"遇见", @"即珍惜"]]];
    }
    return _tagNameArray;
}
@end
