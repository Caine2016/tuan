//
//  FeedBackVC.m
//  buddhismYDniu
//
//  Created by aolei on 16/6/6.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "FeedBackVC.h"
#import "ZLPhoto.h"
#import "ZLPhotoAssets.h"
#import "ZLCameraViewController.h"
#import "ZLCamera.h"

#import "GDFeedBackImageView.h"
//#import "GDMyCenterVM.h"

@interface FeedBackVC ()<UITextViewDelegate,ZLPhotoPickerViewControllerDelegate>{
    ///输入框
    UITextView *_textView;
    ///替换文字
    UILabel *_placeLb;
    ///输入数量
    UILabel *_countL;
}

///图片
@property (nonatomic, strong) UIView              *imageItems;
@property (nonatomic, strong) NSMutableArray      *imgList;//
@property (nonatomic, strong) UIImage             *tmpImage;
@property (nonatomic,strong ) GDFeedBackImageView *imageView;

@end

@implementation FeedBackVC

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///创建视图
    [self _createSubNavBar];
    [self _createViews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark -创建视图
- (void)_createSubNavBar{
    self.customTitle = @"建议反馈";
  
    

    
    
}

- (void)_selectPicture{
    
    if (self.imgList.count >= 3) {
        [ShowHUD showWarn:@"最多选择三张图片!"];
        return;
    }
    ZLPhotoPickerViewController *pickerVc = [[ZLPhotoPickerViewController alloc] init];
    pickerVc.status = PickerViewShowStatusCameraRoll;
    pickerVc.delegate = self;
    pickerVc.maxCount = 3 - self.imgList.count;
    [pickerVc showPickerVc:self];
}

-(GDFeedBackImageView *)imageView{
    if (!_imageView) {
        _imageView = [[GDFeedBackImageView alloc] initWithFrame:CGRectMake(0, _textView.bottom + 10, kScreenWidth, (kScreenWidth - 60)/3+30+10)];
        
        WS(weakSelf);
        _imageView.feedbackImgBLock = ^{
            [weakSelf _selectPicture];
        };
        
        _imageView.deleteImgBLock = ^(NSInteger index) {
            
            
            CNSLog(@"index==%ld",(long)index);
            
            [weakSelf.imgList removeObjectAtIndex:index];
            
            weakSelf.imageView.imgList = weakSelf.imgList;
            
            [weakSelf.imageView addImageList];
         
            
        };
       
    }
    return _imageView;
}

- (void)_createViews{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0,kBaseTopHeight,kScreenWidth ,(kScreenWidth - 24)*0.5)];
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.returnKeyType = UIReturnKeyDone;
    _textView.font = font(17.f);
    _textView.textColor = [UIColor colorWithHexString:@"999999"];
    _textView.editable = YES;
    _textView.delegate = self;
    _textView.layer.borderWidth = SINGLE_LINE_WIDTH;
    _textView.layer.borderColor = RGBCOLOR(228, 229, 230).CGColor;
    [self.view addSubview:_textView];
    
    //代替文字
    _placeLb = [[UILabel alloc] initWithFrame:CGRectMake(_textView.left+10, _textView.top+6, 260, 21)];
    _placeLb.font = font(17.f);
    _placeLb.text = @"请输入您宝贵的意见和反馈...";
    _placeLb.enabled = NO;
    _placeLb.textColor = RGBCOLOR(187, 188, 189);
    _placeLb.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_placeLb];
    
    [self.view addSubview:self.imageView];
    
    _countL = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 95,_textView.bottom - 28, 85, 25)];
    _countL.font = font(17.f);
    _countL.textColor = RGBCOLOR(166, 167, 168);
    _countL.textAlignment = NSTextAlignmentRight;
    _countL.text = @"0/400";
    [self.view addSubview:_countL];
    
    UIButton* submitBtn = [UIButton buttonWithFrame:CGRectZero normalTitle:@"提交" normalColor:KVCBGWhiteColor higlightedTitle:nil higlightedColor:nil selectedTitle:nil selectedColor:nil target:self action:@selector(determineAction)];
    
    submitBtn.layer.masksToBounds = YES;
    submitBtn.backgroundColor = kColorLogin;
    submitBtn.layer.cornerRadius = BaseBtnHeight49/2;
    [self.view addSubview:submitBtn];
    CGFloat padding = 15;
    submitBtn.sd_layout
    .topSpaceToView(self.imageView, 20)
    .leftSpaceToView(self.view, padding)
    .rightSpaceToView(self.view, padding)
    .heightIs(BaseBtnHeight49);
    

}

-(NSMutableArray *)imgList{
    if (!_imgList) {
        _imgList = [NSMutableArray array];
    }
    return _imgList;
}

#pragma mark -ZLPhotoPickerViewControllerDelegate方法
- (void)pickerViewControllerDoneAsstes:(NSArray *)assets{
   // NSUInteger index = self.imgList.count;
    for (int i = 0; i < assets.count; i++) {
      
        
        ZLPhotoAssets *asset = assets[i];
   
       // [self.imageView.imgList addObject:asset.originImage];
        
        [self.imgList addObject:asset.originImage];
        
        

    }
     self.imageView.imgList = self.imgList;
     [self.imageView addImageList];
    
}
- (void)delBtnAction:(UIGestureRecognizer*)recognizer{
    UIImageView *tmpImgView = (UIImageView*)recognizer.view;
    
    [self.imgList removeObjectAtIndex:tmpImgView.tag - 100];
    
    NSUInteger index = tmpImgView.tag - 100;
    
    [tmpImgView removeFromSuperview];
    
    if (index == 0) {//第一张
        for (int i = 0; i < self.imgList.count; i++) {
            UIImageView *img = (UIImageView*)[_imageItems viewWithTag:i+101];
            img.left = img.left-60;
            img.tag = i+100;
        }
    }else if(index == 1){//删除第二张
        for (int i = 1; i < self.imgList.count; i++) {
            UIImageView *img = (UIImageView*)[_imageItems viewWithTag:i+101];
            img.left = img.left - 60;
            img.tag = i+100;
        }
    }
}

#pragma mark -UITextViewDelegate协议方法
- (void)textViewDidChange:(UITextView *)textView{
    if (_textView.text.length == 0) {
        _placeLb.text = @"请输入您宝贵的意见...";
    }else{
        _placeLb.text = @"";
    }
    _countL.text = [NSString stringWithFormat:@"%lu/400",(unsigned long)textView.text.length];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (_textView.text.length == 0) {
        _placeLb.text = @"请输入您宝贵的意见...";
    }else{
        _placeLb.text = @"";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -点击事件
- (void)determineAction{
    
 
    
    
    if (_textView.text.length == 0) {
        [ShowHUD showErrorStatus:@"意见不能为空!"];
//        [self _showMessage:@"意见不能为空!"];
        return;
    }
    
    if (_textView.text.length > 400) {
        [ShowHUD showErrorStatus:@"意见不能超过400个文字!"];
//        [self _showMessage:@"意见不能超过140个文字!"];
        return;
    }
    [self.view endEditing:YES];
    
    
    

}



@end
