//
//  UIImageView+YLHelpMe.h
//  YPTuan
//
//  Created by gd on 2018/12/13.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YLHelpMe)

///网络加载图片
- (void)hg_setImageIconWithUrlString:(id)urlString placeholder:(NSString *)placeholder;
- (void)setMemcacheImageIconWithUrlString:(id )urlString placeholder:(NSString *)placeholder;
@end
