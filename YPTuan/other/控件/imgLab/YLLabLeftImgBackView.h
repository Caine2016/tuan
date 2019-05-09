//
//  YLLabLeftImgBackView.h
//  YPTuan
//
//  Created by Caine on 2018/12/1.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLLabLeftImgBackView : UIView

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) dispatch_block_t didLabLeftImgBackViewBlock;

@end

NS_ASSUME_NONNULL_END
