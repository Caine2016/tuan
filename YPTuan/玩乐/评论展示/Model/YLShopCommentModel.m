//
//  YLShopCommentModel.m
//  YPTuan
//
//  Created by gd on 2018/12/6.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLShopCommentModel.h"

extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;

@implementation YLShopCommentModel{
    CGFloat _lastContentWidth;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"commentImages" : [YLMerchantImagesModel class],
             };
}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}

- (NSString *)content
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
        _lastContentWidth = contentW;
        CGRect textRect = [_content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }
    }
    
    return _content;
}

@end
