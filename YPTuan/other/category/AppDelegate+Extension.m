//
//  AppDelegate+Extension.m
//  YPTuan
//
//  Created by gd on 2018/12/7.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "AppDelegate+Extension.h"

@implementation AppDelegate (Extension)
-(void) monitoringNetwork{
#pragma mark ---网络监控--
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{///未知网络
                [[[UIAlertView alloc] initWithTitle:@"未知网络连接!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{///没有连接到网络
                [[[UIAlertView alloc] initWithTitle:@"当前无网络连接!" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{///移动数据连接
                
                [self getLoginStatus];
                
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{///WI-FI连接
                [self getLoginStatus];
            }
                break;
                
            default:
                break;
        }
    }];
    [reachabilityManager startMonitoring];
}

-(void) getLoginStatus{
    
    NSString* userName = [[EGOCache globalCache] stringForKey:SaveIphoneLocality];
    if (!userName || userName.length <= 0) {
        return;
    }
    
    [BaseDataServiceSISingle getUrl:GetLoginStatus andParamstr:userName andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
        CNSLog(@"%@--returnData",responseData.returnMsg);
        
        if (!succ) return ;
        
        if ([responseData.returnCode isEqualToString:ResponseDataReturnCodeTypeSuccess]) {
            
            
            [BaseDataServiceSISingle getUrl:GetUserInfoUrl andParamstr:userName andResult:^(BOOL succ, BaseResponse * _Nonnull responseData) {
                CNSLog(@"%@--returnData",responseData.returnData);           
                [YLUserModel mj_objectWithKeyValues:responseData.returnData];
                [GDNotificationCenter postNotificationName:LoginOrLogOutNotification object:nil];
                
            }];
        }
        
    }];
    
}
@end
