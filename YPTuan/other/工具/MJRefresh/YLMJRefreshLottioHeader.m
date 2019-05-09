//
//  YLMJRefreshLottioHeader.m
//  YPTuan
//
//  Created by gd on 2018/12/5.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLMJRefreshLottioHeader.h"
#define MIN_HEIGHT 50.0

@interface YLMJRefreshLottioHeader ()
@property (nonatomic,strong) LOTAnimationView *animateLoading;
@property (nonatomic,strong) LOTAnimationView *animateBegin;

@property (nonatomic,strong) UIView *cuteView;

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end

@implementation YLMJRefreshLottioHeader

#pragma mark - 重写方法

#pragma mark 在这里做一些初始化配置（比如添加子控件）

- (void)prepare

{
    
    [super prepare];
    
    self.layer.zPosition = -1;
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    
    self.mj_h = MIN_HEIGHT;
    
    self.cuteView = [[UIView alloc]init];
    
    self.cuteView.backgroundColor = RGBCOLOR(246, 247, 248);
    
    [self addSubview:self.cuteView];
    
    self.animateBegin.hidden = NO;
    self.animateLoading.hidden = NO;
    
    [self configShapeLayer];
    
}
#pragma mark 在这里设置子控件的位置和尺寸

- (void)placeSubviews

{
    
    [super placeSubviews];
    
    self.cuteView.frame = CGRectMake(0, 0, self.mj_w, MIN_HEIGHT);
    
}
-(LOTAnimationView *)animateBegin

{
    
    if (_animateBegin == nil) {
        
        _animateBegin = [LOTAnimationView animationNamed:@"Ping_Pongloading"];
        
        _animateBegin.loopAnimation = NO;
        
        _animateBegin.frame = CGRectMake(0, 0, 50, 50);
        
        [self addSubview:_animateBegin];
        
        //        [self addSubview:self.testView];
        
    }
    
    return _animateBegin;
    
}



-(LOTAnimationView *)animateLoading

{
    
    if (_animateLoading == nil) {
        
        _animateLoading = [LOTAnimationView animationNamed:@"Ping_Pongloading"];
        
        _animateLoading.loopAnimation = YES;
        
        _animateLoading.frame = CGRectMake(0, 0, 100, 50);
        
        [self addSubview:_animateLoading];
        
    }
    
    return _animateLoading;
    
}

- (void)configShapeLayer

{
    
    _shapeLayer = [CAShapeLayer layer];
    
    _shapeLayer.fillColor = RGBCOLOR(246, 247, 248).CGColor;
    
    [self.cuteView.layer addSublayer:_shapeLayer];
    
}

- (void)updateShapeLayerPath:(CGFloat)offsetY

{
    
    // 更新_shapeLayer形状
    
    UIBezierPath *tPath = [UIBezierPath bezierPath];
    
    [tPath moveToPoint:CGPointMake(0, 0)];                              // r1点
    
    [tPath addLineToPoint:CGPointMake(self.cuteView.width, 0)];            // r2点
    
    [tPath addLineToPoint:CGPointMake(self.cuteView.width,  MIN_HEIGHT)];  // r4点
    
    [tPath addQuadCurveToPoint:CGPointMake(0, MIN_HEIGHT)
     
                 controlPoint:CGPointMake(self.cuteView.width/2, -offsetY)]; // r3,r4,r5确定的一个弧线
    
    [tPath closePath];
    
    _shapeLayer.path = tPath.CGPath;
    
}

#pragma mark 监听scrollView的contentOffset改变

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change

{
    
    [super scrollViewContentOffsetDidChange:change];
    
    CGPoint nPoint = [[change objectForKey:@"new"] CGPointValue];
    
    //    DLog(@"contentOffset改变:%@,,%f",change,nPoint.y);
    
    CGFloat animateY = 0;
    
    if (nPoint.y + MIN_HEIGHT <= 0) {
        
        self.cuteView.y = nPoint.y + MIN_HEIGHT;
        
        animateY = nPoint.y + MIN_HEIGHT + MIN_HEIGHT/2;
        
    }else{
        
        self.cuteView.y = 0;
        
        animateY =MIN_HEIGHT+nPoint.y/2;
        
    }
    
    [self updateShapeLayerPath:nPoint.y];
    
    self.animateLoading.center = CGPointMake(self.mj_w/2, animateY);
    
    self.animateBegin.center = self.animateLoading.center;
    
    if (nPoint.y == 0) {
        
        [UIView animateWithDuration:0.1 animations:^{
            
           self.animateBegin.center = CGPointMake(self.animateBegin.center.x, self.animateBegin.centerY - 25);
            
        }];
        
    }
    
}

#pragma mark 监听scrollView的contentSize改变

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change

{
    
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变

- (void)scrollViewPanStateDidChange:(NSDictionary *)change

{
    
    [super scrollViewPanStateDidChange:change];
    
   //     DLog(@"拖拽状态改变:%@",change);
    
}


#pragma mark 监听控件的刷新状态

- (void)setState:(MJRefreshState)state

{
    
    MJRefreshCheckState;
    
    // 根据状态做事情
    
    if (state == MJRefreshStateIdle) {
        
        if (oldState == MJRefreshStateRefreshing) {
            
            self.animateBegin.hidden = NO;
            
            self.animateLoading.hidden = YES;
            
            [self.animateLoading pause];
            
        }else if( oldState == MJRefreshStatePulling) {
            
            self.animateBegin.hidden = NO;
            
            self.animateLoading.hidden = YES;
            
            [self.animateLoading pause];
            
        }else{
            
            self.animateBegin.hidden = YES;
            
            self.animateLoading.hidden = YES;
            
            [self.animateLoading pause];
            
        }
        
    }else if (state == MJRefreshStatePulling) {
        
        self.animateBegin.hidden = NO;
        
        self.animateLoading.hidden = YES;
        
        [self.animateLoading pause];
        
    }else if (state == MJRefreshStateRefreshing) {
        
        self.animateBegin.hidden = YES;
        
        self.animateLoading.hidden = NO;
        
        self.animateLoading.animationProgress = 0;
        
        [self.animateLoading play];
        
    }else{
        
        self.animateBegin.hidden = YES;
        
        self.animateLoading.hidden = YES;
        
    }
    
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）

- (void)setPullingPercent:(CGFloat)pullingPercent

{
    
    [super setPullingPercent:pullingPercent];
    
    //    DLog(@"当前进度：%f",pullingPercent);
    
    CGFloat progressBegin = pullingPercent - 1 > 0 ? 1.0:pullingPercent;
    
    self.animateBegin.animationProgress = progressBegin*0.64;
    
}



@end
