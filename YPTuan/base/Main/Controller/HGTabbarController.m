//
//  HGTabbarController.m
//  HiGo
//
//  Created by caine on 2017/9/19.
//  Copyright © 2017年 Think_lion. All rights reserved.
//

#import "HGTabbarController.h"
#import "HGGlobalController.h"
#import "HGFineController.h"
#import "HGCarController.h"
#import "HGMeController.h"
#import "HGNavController.h"
#import "HGTabView.h"
#import "TabVCModel.h"

#import "BaseNavigationVC.h"
@interface HGTabbarController ()<HGTabViewDelegate,UITabBarControllerDelegate>
@property (nonatomic,weak) HGTabView *tabView;
@property (nonatomic,strong) LOTAnimationView *lottieLogo;

@end

@implementation HGTabbarController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加底部自定义的标签栏
  //  [self setupTabBar];
    //2.添加子控制器
    [self addChildVc];
 
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //  [self launchAnimation];
    
}
#pragma mark - Private Methods
- (void)launchAnimation {
   UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    
    UIView *launchView = viewController.view;
    launchView.backgroundColor = KVCBGWhiteColor;

    
    [launchView addSubview:self.lottieLogo];
    self.lottieLogo.sd_layout
    .spaceToSuperView(UIEdgeInsetsMake(100, 0, 100, 0));
    [self.lottieLogo play];
    
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    launchView.frame = [UIApplication sharedApplication].keyWindow.frame;
    [mainWindow addSubview:launchView];
    
    [UIView animateWithDuration:3.f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.0f, 1.0f, 1.0f);
    } completion:^(BOOL finished) {
        [launchView removeFromSuperview];
        [self.lottieLogo stop];
    }];
    
}


-(LOTAnimationView *)lottieLogo{
    if (!_lottieLogo) {
        _lottieLogo = [LOTAnimationView animationNamed:@"launchAM"];
        _lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
        _lottieLogo.loopAnimation = YES;
    }
    return _lottieLogo;
}

#pragma mark 添加底部的标签栏
-(void)setupTabBar
{
//    for(UIView *child in self.tabBar.subviews){
//        //        if([child isKindOfClass:[UIControl class]]){
//        //            [child removeFromSuperview];
//        //        }
//        Class class = NSClassFromString(@"UITabBarButton");
//        if ([child isKindOfClass:class]) {
//            [child removeFromSuperview];
//        }
//    }
//    HGTabView *tabView=[[HGTabView alloc]initWithFrame:self.tabBar.bounds];
//    tabView.delegate=self;
//  //  [self.tabBar addSubview:tabView];
//
//    self.tabView=tabView;
    
}
#pragma mark 实现底部标签栏按钮点击的代理方法
-(void)tabView:(HGTabView *)tabView didSelectedFrom:(int)from toIndex:(int)to
{
    self.selectedIndex = to;
    if (to == 2) {
        if (UserModelSisingle.userId.length < 0) {
            if ([UserModelSisingle userId].length <= 0) {
                YLLoginController* loginVC = [YLLoginController new];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:YES];
                return ;
            }
        }
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}
#pragma mark 添加子控制器
-(void)addChildVc
{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"MainVCSettings.json" ofType:nil];
        if (filePath == nil) {
            CNSLog(@"JSON文件不存在");
            [self defaultLoadController];
            return ;
        }
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data == nil) {
             CNSLog(@"加载二进制数据失败");
            [self defaultLoadController];
            return ;
        }
        NSArray* vcArray = [TabVCModel mj_objectArrayWithKeyValuesArray:data];
    
       
        for (TabVCModel* vc in vcArray) {
            NSString *imgH = [NSString stringWithFormat:@"%@H",vc.imageName];
            [self addChildViewController:vc.vcName title:vc.title image:vc.imageName selectedImage:imgH];
        }
  //  });
    
    }
-(void) defaultLoadController{
    
    //1.添加首页控制器
    [self addChildViewController:@"HGFineController" title:@"精选" image:@"home" selectedImage:@"homeH"];

    [self addChildViewController:@"HGGlobalController" title:@"玩乐" image:@"earth" selectedImage:@"earthH"];

    [self addChildViewController:@"HGCarController" title:@"订单" image:@"Message" selectedImage:@"MessageH"];

    [self addChildViewController:@"HGMeController" title:@"我的" image:@"cart" selectedImage:@"cartH"];


}
#pragma mark 添加子控制器的方法

-(void)addChildViewController:(NSString *)vcClassName title:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage


{
     Class childVcClass = NSClassFromString(vcClassName);
    
    if (childVcClass) {
        UIViewController* childVc = [[childVcClass alloc] init];
        
        NSMutableDictionary *atts = [NSMutableDictionary dictionary];
        atts[NSFontAttributeName] = HNW3Font(14);
        atts[NSForegroundColorAttributeName] = kColorTitleTabbarNormal;
        
        NSMutableDictionary *selectedAtts = [NSMutableDictionary dictionary];
        selectedAtts[NSFontAttributeName] = atts[NSFontAttributeName];
        selectedAtts[NSForegroundColorAttributeName] = kColorTitleTabbarSelect;
        // 在这里 只要更改，所有的文字都改
        
        UITabBarItem *item = [UITabBarItem appearance];
        [item setTitleTextAttributes:atts forState:UIControlStateNormal];
        [item setTitleTextAttributes:selectedAtts forState:UIControlStateSelected];
        
        
        childVc.title = title;
       // childVc.tabBarItem.title = title;
        UIImage* imageTab = [UIImage imageNamed:selectedImage];
         imageTab = [imageTab imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVc.tabBarItem.image = [UIImage imageNamed:image];
        childVc.tabBarItem.selectedImage=imageTab;
        
//        if ([vcClassName isEqualToString:@"HGGlobalController"]) {
//
//            HGNavController *nav=[[HGNavController alloc]initWithRootViewController:childVc];
//
//            [self addChildViewController:nav];
//
//
//
//        }else{
            BaseNavigationVC *nav=[[BaseNavigationVC alloc]initWithRootViewController:childVc];
            
            [self addChildViewController:nav];
       // }
       
        [self.tabView addTabItem:childVc.tabBarItem];
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
