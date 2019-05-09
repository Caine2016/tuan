//
//  YLMyHeaderView.h
//  YPTuan
//
//  Created by Caine on 2018/11/10.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLMyHeaderView : UIView

@property (nonatomic, strong) LOTAnimationView *lottieLogo;


@property (nonatomic,copy) dispatch_block_t didHeaderViewBlock;  ///头部空白点击
@property (nonatomic,copy) dispatch_block_t didSettingTapBlock;  ///设置按钮点击
@property (nonatomic,copy) void (^didMyCollectBtnBlock)(YLMerchantOrArtificerIdType type); ///收藏按钮点击

-(void) updataView;
@end

NS_ASSUME_NONNULL_END
