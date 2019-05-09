//
//  YLLabHeaderView.h
//  YPTuan
//
//  Created by gd on 2018/11/20.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define titleLabHeaderH  40
#define subLabHeaderTitleH  25

@interface YLLabHeaderView : UIView

@property (nonatomic,copy) dispatch_block_t didMoreBlock;

-(instancetype)initWithFrame:(CGRect)frame andTitle:(nonnull NSString*)title andSubTitle:(NSString*)subTitle andRightTitle:(NSString*)rightTitle;



@end
