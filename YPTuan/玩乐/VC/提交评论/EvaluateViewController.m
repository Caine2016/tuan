//
//  EvaluateViewController.m
//  PhotoSelector
//
//  Created by 洪雯 on 2017/1/12.
//  Copyright © 2017年 洪雯. All rights reserved.
//

#import "EvaluateViewController.h"
#import "BRPlaceholderTextView.h"
#import "UIImageView+WebCache.h"
#import "XFCustomEView.h"
#import "YLShopCommentModel.h"
#define iphone4 (CGSizeEqualToSize(CGSizeMake(320, 480), [UIScreen mainScreen].bounds.size))
#define iphone5 (CGSizeEqualToSize(CGSizeMake(320, 568), [UIScreen mainScreen].bounds.size))
#define iphone6 (CGSizeEqualToSize(CGSizeMake(375, 667), [UIScreen mainScreen].bounds.size))
#define iphone6plus (CGSizeEqualToSize(CGSizeMake(414, 736), [UIScreen mainScreen].bounds.size))
//默认最大输入字数为  kMaxTextCount  300
#define kMaxTextCount 300
#define HeightVC [UIScreen mainScreen].bounds.size.height//获取设备高度
#define WidthVC [UIScreen mainScreen].bounds.size.width//获取设备宽度

@interface EvaluateViewController ()<UIScrollViewDelegate,UITextViewDelegate>
{
    float _TimeNUMX;
    float _TimeNUMY;
    int _FontSIZE;
    float allViewHeight;
    //备注文本View高度
    float noteTextHeight;
}

/**
 *  主视图-
 */
@property (nonatomic, strong) UIScrollView *mianScrollView;
@property (nonatomic, strong) BRPlaceholderTextView *noteTextView;
//背景
@property (nonatomic, strong) UIView *noteTextBackgroudView;
//文字个数提示label
@property (nonatomic, strong) UILabel *textNumberLabel;

@property (nonatomic,strong) YLShopCommentModel *shopCommentModel;

@property (nonatomic,strong) NSString *commentContent; //评论内容
@property (nonatomic,strong) NSString * tagContent; //评论标签
@property (nonatomic,strong) NSString *sort; //评分

//图片
//@property (nonatomic,strong) UIImageView *photoImageView;

//文字介绍
@property (nonatomic,strong) UIView * lineVCThree;
@property (nonatomic,strong) UIButton * sureBtn;
@property (nonatomic,strong) NSMutableDictionary * upDic;
@property (nonatomic,strong) NSMutableArray * photoArr;
@property (nonatomic,copy)   NSString * photoStr;
@property (nonatomic,copy)   NSString * star_level;

@property (nonatomic, strong) NSMutableArray <NSMutableArray *>* tagArray; /**< 标签数组 */
@property (nonatomic, strong) NSMutableArray * tagNameArray; /**< 标签名字数组 */
@property (nonatomic, strong) XFCustomEView * evalueTopBgView; /**< 顶部评价背景 */

@end

@implementation EvaluateViewController
WYGetter_MutableArray(tagArray)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    //收起键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    self.star_level = @"1";
    
    //监听键盘出现和消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    _TimeNUMX = [self BackTimeNUMX];
    _TimeNUMY = [self BackTimeNUMY];
    
    [self createUI];
}

/**
 *  取消输入
 */
- (void)viewTapped{
    [self.view endEditing:YES];
}
#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    self.view.frame = CGRectMake(0, 0-200*_TimeNUMY, WidthVC,HeightVC);
}
#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.view.frame = CGRectMake(0, 0, WidthVC, HeightVC);
}

- (void)createUI{
    _mianScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kBaseTopHeight, WidthVC, HeightVC)];
    _mianScrollView.contentSize =CGSizeMake(WidthVC, HeightVC);
    _mianScrollView.bounces =YES;
    _mianScrollView.showsVerticalScrollIndicator = false;
    _mianScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_mianScrollView];
    [_mianScrollView setDelegate:self];
    self.showInView = _mianScrollView;
    
    /** 初始化collectionView */
    [self initPickerView];
    
    [self initViews];
}

/**
 *  初始化视图
 */
- (void)initViews{
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor whiteColor];
    
    ///照片
//    self.photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*_TimeNUMX, 20*_TimeNUMY, 80*_TimeNUMX, 90*_TimeNUMY)];
//    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:self.modelUrl] placeholderImage:[UIImage imageNamed:@"plus"]];
//    UIButton * clickImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(20*_TimeNUMX, 20*_TimeNUMY, 80*_TimeNUMX, 90*_TimeNUMY)];
//    [clickImageBtn addTarget:self action:@selector(ClickImage:) forControlEvents:UIControlEventTouchUpInside];
//    clickImageBtn.backgroundColor = [UIColor clearColor];
    
    self.evalueTopBgView = [[XFCustomEView alloc] init];
    self.evalueTopBgView.titlesArr = self.tagNameArray[0];
    __weak typeof(self) weakSelf = self;
    self.evalueTopBgView.refreshView = ^(XFEvaluateRank *button) {
        
        if (button) {
            weakSelf.evalueTopBgView.titlesArr = weakSelf.tagNameArray[(int)button.tag - 100];
            NLog(@"%d--button.tag",(int)button.tag - 100);
            [weakSelf.evalueTopBgView addDymView];
            [weakSelf updateViewsFrame];
            
            weakSelf.sort = [NSString stringWithFormat:@"%d",((int)button.tag - 100 +1)];

        }
       
        NLog(@"%@--weakSelf.evalueTopBgView.titlesArr",weakSelf.evalueTopBgView.resultArray);
        ///获取推荐biao'q
        NSArray* strArr = weakSelf.evalueTopBgView.resultArray[2];
        NSMutableString * tagName = [NSMutableString string];
        [strArr enumerateObjectsUsingBlock:^(NSNumber*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger index = [obj integerValue];
            NSString* tag = weakSelf.evalueTopBgView.titlesArr[index];
            [tagName appendString:[NSString stringWithFormat:@"%@-",tag]];
        }];

        weakSelf.tagContent = tagName;
        
        NLog(@"weakSelf.tagContent %@",weakSelf.tagContent);

    };
    

    
    //文本输入框
    _noteTextView = [[BRPlaceholderTextView alloc]init];
    _noteTextView.keyboardType = UIKeyboardTypeDefault;
    //文字样式
    [_noteTextView setFont:[UIFont fontWithName:@"Heiti SC" size:15.5]];
    _noteTextView.maxTextLength = kMaxTextCount;
    [_noteTextView setTextColor:[UIColor blackColor]];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:15.5];
    _noteTextView.placeholder= @"    来分享您...";
    self.noteTextView.returnKeyType = UIReturnKeyDone;
    [self.noteTextView setPlaceholderColor:[UIColor lightGrayColor]];
    [self.noteTextView setPlaceholderOpacity:1];
    _noteTextView.textContainerInset = UIEdgeInsetsMake(5, 15, 5, 15);
    
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = [NSString stringWithFormat:@"0/%d    ",kMaxTextCount];
    
    self.lineVCThree = [[UIView alloc] init];
    self.lineVCThree.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //确定按钮
    self.sureBtn = [[UIButton alloc] init];
    self.sureBtn.backgroundColor = kColorLogin;
    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:17.0+_FontSIZE];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setTitleColor:kColorLogin forState:UIControlStateHighlighted];
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.layer.cornerRadius = BaseCornerRadius;
    [self.sureBtn addTarget:self action:@selector(ClickSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [_mianScrollView addSubview:self.evalueTopBgView];
    [_mianScrollView addSubview:_noteTextView];
    [_mianScrollView addSubview:_textNumberLabel];
    [_mianScrollView addSubview:self.lineVCThree];
    [_mianScrollView addSubview:self.sureBtn];
    
    
    [self updateViewsFrame];
    
}

/**
 *  界面布局 frame
 */
- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 150*_TimeNUMY;
    }
    
    _noteTextBackgroudView.frame = CGRectMake(0, 0, WidthVC, 200*_TimeNUMY);
    
    //文本编辑框
    _noteTextView.frame = CGRectMake(0, self.evalueTopBgView.frame.origin.y+self.evalueTopBgView.frame.size.height, WidthVC, noteTextHeight);
    
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15*_TimeNUMY      , WidthVC-10*_TimeNUMX, 15*_TimeNUMY);
    
    self.lineVCThree.frame = CGRectMake(0*_TimeNUMX,_noteTextView.frame.origin.y+_noteTextView.frame.size.height, WidthVC, 10*_TimeNUMY);
    
    //photoPicker
    [self updatePickerViewFrameY:self.lineVCThree.frame.origin.y + self.lineVCThree.frame.size.height];
    
    self.sureBtn.frame = CGRectMake(20*_TimeNUMX, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+30*_TimeNUMY, WidthVC-BaseBtnHeight49*_TimeNUMX, BaseBtnHeight49*_TimeNUMY);
    
    allViewHeight = self.sureBtn.frame.origin.y+self.sureBtn.frame.size.height+10*_TimeNUMY +self.evalueTopBgView.height;
    
    _mianScrollView.contentSize = self.mianScrollView.contentSize = CGSizeMake(0,allViewHeight);
}
/**
 *  恢复原始界面布局
 */
-(void)resumeOriginalFrame{
    _noteTextBackgroudView.frame = CGRectMake(0, 0, WidthVC, 200*_TimeNUMY);
    //文本编辑框
    _noteTextView.frame = CGRectMake(0, 40*_TimeNUMY, WidthVC, noteTextHeight);
    
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15*_TimeNUMY      , WidthVC-10*_TimeNUMX, 15*_TimeNUMY);
}

- (void)pickerViewFrameChanged{
    [self updateViewsFrame];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    //当前输入字数
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    [self textChanged];
    return YES;
}

//文本框每次输入文字都会调用  -> 更改文字个数提示框
- (void)textViewDidChangeSelection:(UITextView *)textView{
    //
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/%d    ",(unsigned long)_noteTextView.text.length,kMaxTextCount];
    if (_noteTextView.text.length > kMaxTextCount) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self textChanged];
}

/**
 *  文本高度自适应
 */
-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    //获取尺寸
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    
    //如果文本框没字了恢复初始尺寸
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }else{
        noteTextHeight = 100;
    }
    
    [self updateViewsFrame];
}

#pragma mark - UIScrollViewDelegate
//用户向上偏移到顶端取消输入,增强用户体验
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        [self.view endEditing:YES];
    }
}

#pragma mark 点击出大图方法
- (void)ClickImage:(UIButton *)sender{
    
}

#pragma mark 确定评价的方法
- (void)ClickSureBtn:(UIButton *)sender{
   // weakSelf.evalueTopBgView.resultArray
    if (self.tagContent) {
        self.commentContent = [[NSString stringWithFormat:@"#%@#",self.tagContent] stringByAppendingString:self.noteTextView.text];
    }
    if (self.commentContent.length == 0 || self.commentContent.length < 3) {
        
        [ShowHUD showWarn:@"您的评价描述字数要至少3个字哦!"];
        
        return;
    }
    if (self.commentContent.length > kMaxTextCount) {
        [ShowHUD showWarn:@"您的评价描述字数太多了哦!"];
        return;
    }
    
    self.photoArr = [[NSMutableArray alloc] initWithArray:[self getBigImageArray]];
    
    if (self.photoArr.count >9){
         [ShowHUD showWarn:@"最多上传9张照片!"];
        
    }else{
        
        NSString *encodedString = [URLStringCode urlEncodeStr:self.commentContent];
      
        NLog(@"encodedString = %@",encodedString);
        YPCommentsMerchantPushModel* pushModel = [YPCommentsMerchantPushModel new];
        pushModel.userName = [UserModelSisingle userName];
        pushModel.userId = [UserModelSisingle userId];
        
        pushModel.merchantId = (_type == YLMerchantOrArtificerIdTypeMerchant) ? self.dealsModel.merchantId : self.artificerModel.merchantId;
        if (_type == YLMerchantOrArtificerTypeArtificer) {
            pushModel.artificerId = self.artificerModel.artificerId;
        }
        pushModel.type = @(_type);
        pushModel.content = encodedString;
        pushModel.score = self.sort;
        
        NSDictionary* parmsDic = pushModel.mj_keyValues;
        [ShowHUD show];
        
        NSString* commentURL = _type == YLMerchantOrArtificerIdTypeMerchant ? CommentsMerchantUrl : GetAllArtificerCommentUrl;
        ///上传评论
        [BaseDataServiceSISingle postUrlJoiningTogether:commentURL andParams:parmsDic andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
            
            YLShopCommentModel* shopCommentModel = [YLShopCommentModel mj_objectWithKeyValues:responseData.returnData];
            
            NLog(@"shopCommentcontent = %@",shopCommentModel.commentId);
            if (self.photoArr.count > 0 || shopCommentModel.commentId.length > 1) {
                
                ///上传图片
                [BaseDataServiceSISingle updataImageToUrl:UpdataCommentsImagUrl andParms:@{@"commentId":shopCommentModel.commentId} andIamgeArr:self.photoArr andSuccess:^{
                    
                    [ShowHUD dismiss];
                    [GDNotificationCenter postNotificationName:CommentSuccessBack object:nil userInfo:nil];
                    [self backAction];


                }];
                
            }else{
                
                [ShowHUD dismiss];
                
                 [GDNotificationCenter postNotificationName:CommentSuccessBack object:nil userInfo:nil];
                 [self backAction];
                
            }
                

        }];
        
    

        
        
    }
}

#pragma mark 返回不同型号的机器的倍数值
- (float)BackTimeNUMX {
    float numX = 0.0;
    if (iphone4) {
        numX = 320 / 375.0;
        return numX;
    }
    if (iphone5) {
        numX = 320 / 375.0;
        return numX;
    }
    if (iphone6) {
        return 1.0;
    }
    if (iphone6plus) {
        numX = 414 / 375.0;
        return numX;
    }
    return numX;
}
- (float)BackTimeNUMY {
    float numY = 0.0;
    if (iphone4) {
        numY = 480 / 667.0;
        _FontSIZE = -2;
        return numY;
    }
    if (iphone5) {
        numY = 568 / 667.0;
        _FontSIZE = -2;
        return numY;
    }
    if (iphone6) {
        _FontSIZE = 0;
        return 1.0;
    }
    if (iphone6plus) {
        numY = 736 / 667.0;
        _FontSIZE = 2;
        return numY;
    }
    return numY;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSMutableArray *)tagNameArray{
    if (_tagNameArray == nil) {
        _tagNameArray = [[NSMutableArray alloc] init];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"不是", @"一个糖"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"不是", @"一杯水"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"更不是", @"不是简简单单的甜言蜜语"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"爱情", @"而是", @"万里挑一的灵魂碰撞"]]];
        [_tagNameArray addObject: [[NSMutableArray alloc] initWithArray:@[@"我们", @"遇见", @"即珍惜"]]];
    }
    return _tagNameArray;
}

@end
