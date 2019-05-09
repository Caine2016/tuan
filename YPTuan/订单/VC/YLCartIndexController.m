//
//  YLCartIndexController.m
//  YPTuan
//
//  Created by gd on 2018/11/22.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLCartIndexController.h"
#import "ZWMSegmentController.h"
#import "HGCarController.h"
@interface YLCartIndexController ()
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@end

@implementation YLCartIndexController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customTitle = @"订单";
    
    [self creatSegmentVC];
    self.bottomLineView.hidden = YES;
}

-(void)creatSegmentVC{
    // self.navigationController.navigationBar.translucent = NO;
    HGCarController *consumptionCoupons = [[HGCarController alloc] init];
    consumptionCoupons.type = ConsumptionCouponsTypeConsumption;
    HGCarController *paymentCoupons = [[HGCarController alloc] init];
    paymentCoupons.type = ConsumptionCouponsTypePayment;

    HGCarController *evaluateCoupons = [[HGCarController alloc] init];
    consumptionCoupons.type = ConsumptionCouponsTypeEvaluate;

    HGCarController *completedCoupons = [[HGCarController alloc] init];
    completedCoupons.type = ConsumptionCouponsTypeCompleted;

    HGCarController *failureCoupons = [[HGCarController alloc] init];
    failureCoupons.type = ConsumptionCouponsTypeFailure;


    
    NSArray *array = @[consumptionCoupons,paymentCoupons,evaluateCoupons,completedCoupons,failureCoupons];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, kBaseTopHeight, kScreenWidth, kScreenHeight-kNavbarHeight) titles:@[@"待消费",@"待付款",@"待评价",@"已完成",@"已失效"] isDynamic:NO];
    
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = kColorLogin;
    self.segmentVC.viewControllers = [array copy];
    
    if (array.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
    
    [self.segmentVC selectedAtIndex:^(NSUInteger index, UIButton * _Nonnull button, UIViewController * _Nonnull viewController) {
        
        
    }];
    
    
}
@end
