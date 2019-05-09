//
//  MJQiaoMuYuHeader.m
//  buddhismYDniu
//
//  Created by aolei on 16/6/14.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "MJQiaoMuYuHeader.h"

@implementation MJQiaoMuYuHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_0%d", i]];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        [idleImages addObject:image];
    }
    [self setImages:idleImages duration:0.5f forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i < 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_0%lu", (unsigned long)i]];
        image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
        [refreshingImages addObject:image];
    }
    ///松开刷新
    [self setImages:@[[refreshingImages firstObject]] duration:0.5f forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.5f forState:MJRefreshStateRefreshing];
    self.lastUpdatedTimeLabel.hidden = YES;
//    self.stateLabel.hidden = YES;
    [self setTitle:@"下拉立即刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载中..." forState:MJRefreshStateWillRefresh];
}
@end
