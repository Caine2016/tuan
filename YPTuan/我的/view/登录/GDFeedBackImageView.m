//
//  GDFeedBackImageView.m
//  buddhismYDniu
//
//  Created by gd on 2018/4/19.
//  Copyright © 2018年 aolei. All rights reserved.
//

#import "GDFeedBackImageView.h"
#import "GDFeedbackImageAndDelView.h"

#define ImageW (kScreenWidth - 60)/3
#define ImageX(i) (10 + (i) % 3 * (ImageW + 20))
@interface GDFeedBackImageView ()

@property (nonatomic,strong) UILabel *countLab;

@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) GDFeedbackImageAndDelView* imageViewCenter;
@property (nonatomic,strong) GDFeedbackImageAndDelView* imageViewLeft;
@property (nonatomic,strong) GDFeedbackImageAndDelView* imageViewRigth;


@end


@implementation GDFeedBackImageView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatView];
    }
    
    return self;
}

//icon_addpic_unfocused

-(void)creatView{
    
    UILabel* titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth - 50, 30)];
    titleLab.textColor = [UIColor blackColor];
    titleLab.font = font(16);
    titleLab.text = @"图片(选填,提供问题截图)";
    [self addSubview:titleLab];
    
    _countLab = [[UILabel alloc] initWithFrame:CGRectMake(titleLab.right, 0, 50, 30)];
    _countLab.textColor = COLOR_999;
    _countLab.font = font(16);
    _countLab.text = @"0/3";
    [self addSubview:_countLab];
    
    
    self.addBtn = [MyButton addBtnImage:@"icon_addpic_unfocused" title:nil tag:0 frame:CGRectMake(10, _countLab.bottom, ImageW, ImageW) andFont:0 andNormalTitleColor:nil andSelectTitleColor:nil andcontentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter andSelectedImg:nil];
    
    [self addSubview:self.addBtn];
    
    [self.addBtn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.imageViewCenter];
    [self addSubview:self.imageViewRigth];
    [self addSubview:self.imageViewLeft];
}


-(void) addImageList{
   
    _countLab.text = [NSString stringWithFormat:@"%lu/3",(unsigned long)self.imgList.count];

        switch (self.imgList.count) {
            case 0:
                {
                     self.imageViewCenter.hidden = YES;
                     self.imageViewLeft.hidden   = YES;
                     self.imageViewRigth.hidden  = YES;
                }
                break;
            case 1:
            {
                self.imageViewCenter.hidden        = YES;
                self.imageViewLeft.hidden          = NO;
                self.imageViewRigth.hidden         = YES;
                self.imageViewLeft.imageView.image = self.imgList[0];
               
            }
                break;
            case 2:
            {
                self.imageViewCenter.hidden          = NO;
                self.imageViewLeft.hidden            = NO;
                self.imageViewRigth.hidden           = YES;
                self.imageViewLeft.imageView.image   = self.imgList[0];
                self.imageViewCenter.imageView.image = self.imgList[1];
            }
                break;
            case 3:
            {
                self.imageViewCenter.hidden          = NO;
                self.imageViewLeft.hidden            = NO;
                self.imageViewRigth.hidden           = NO;
                self.imageViewLeft.imageView.image   = self.imgList[0];
                self.imageViewCenter.imageView.image = self.imgList[1];
                self.imageViewRigth.imageView.image  = self.imgList[2];
            }
                break;
                
            default:
                break;
        }

    
    if (self.imgList.count == 3) {
        self.addBtn.hidden = YES;
        
        return;
        
    }
    self.addBtn.hidden = NO;
    self.addBtn.mj_x = ImageX(self.imgList.count);
}

-(NSArray *)imgList{
    if (!_imgList) {
        _imgList = [NSArray array];
    }
    return _imgList;
}
-(GDFeedbackImageAndDelView *)imageViewLeft{
    if (!_imageViewLeft) {
        _imageViewLeft = [[GDFeedbackImageAndDelView alloc]initWithFrame:CGRectMake(ImageX(0), _countLab.bottom, ImageW, ImageW)];
        WS(weakSelf);
        _imageViewLeft.delViewBlock = ^{
             !weakSelf.deleteImgBLock ? : weakSelf.deleteImgBLock(0);
        };
        _imageViewLeft.hidden = YES;
    }
    return _imageViewLeft;
}
-(GDFeedbackImageAndDelView *)imageViewRigth{
    if (!_imageViewRigth) {
        _imageViewRigth = [[GDFeedbackImageAndDelView alloc]initWithFrame:CGRectMake(ImageX(2), _countLab.bottom, ImageW, ImageW)];
         WS(weakSelf);
        _imageViewRigth.delViewBlock = ^{
            !weakSelf.deleteImgBLock ? : weakSelf.deleteImgBLock(2);
        };
        _imageViewRigth.hidden = YES;
    }
    return _imageViewRigth;
}
-(GDFeedbackImageAndDelView *)imageViewCenter{
    if (!_imageViewCenter) {
        _imageViewCenter = [[GDFeedbackImageAndDelView alloc]initWithFrame:CGRectMake(ImageX(1), _countLab.bottom, ImageW, ImageW)];
         WS(weakSelf);
        _imageViewCenter.delViewBlock = ^{
            !weakSelf.deleteImgBLock ? : weakSelf.deleteImgBLock(1);
        };
        _imageViewCenter.hidden = YES;
    }
    return _imageViewCenter;
}


-(void) addImage{
    !self.feedbackImgBLock ? : self.feedbackImgBLock();
}

@end
