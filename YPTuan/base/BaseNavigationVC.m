//
//  BaseNavigationVC.m
//  aolei_ydniu
//
//  Created by aolei on 16/2/22.
//  Copyright © 2016年 aolei. All rights reserved.
//

#import "BaseNavigationVC.h"

@interface BaseNavigationVC ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation BaseNavigationVC

- (void)viewDidLoad{
    
    __weak BaseNavigationVC *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES; //当push 的时候隐藏底部兰
    }
    
    [super pushViewController:viewController animated:animated];
    
   
    
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] && animated == YES )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return  [super popToRootViewControllerAnimated:animated];
    
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] )
    {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    return [super popToViewController:viewController animated:animated];
    
}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animate{
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    if ( gestureRecognizer == self.interactivePopGestureRecognizer )
    {
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0] )
        {
            return NO;
        }
    }
    
    return YES;
}



- (instancetype)init{
    if (self = [super init]) {
        [self subViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self subViews];
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self subViews];
        BaseVC *rootVC = (BaseVC*)rootViewController;
        rootVC.backButton.hidden = YES;
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass{
    if (self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass]) {
        [self subViews];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self subViews];
        self.navigationBar.hidden = YES;
    }
    return self;
}


- (void)subViews{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationBar setBackgroundImage:[XTools imageWithColor:MainBackColor] forBarMetrics:UIBarMetricsDefault];

    //改变字体颜色
    [self.navigationBar setTranslucent:NO];
    self.navigationBar.titleTextAttributes=@{
                                             NSForegroundColorAttributeName:MainBackColor,
                                             NSFontAttributeName:jsFont(21)};
    self.navigationBar.tintColor = [UIColor whiteColor];
    CGRect rect = CGRectMake(0, 0, kScreenWidth, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   MainBackColor.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationBar setShadowImage:img];
}

@end
