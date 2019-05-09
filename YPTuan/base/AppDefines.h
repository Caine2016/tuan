//
//  AppDefines.h
//  buddhismYDniu
//
//  Created by caine on 2017/9/19.
//  Copyright © 2017年 aolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ENVIRONMENT 0 // 0 正式环境，1测试环境

/* Edit Scheme... -> Run -> Arguments, 在Environment Variables里边添加 OS_ACTIVITY_MODE ＝ disable
 */

extern NSString *const BaseUrl;  ///基础URL
extern NSString *const UserLoginUrl;  //登录
extern NSString *const GetLoginStatus;  //获取登录状态
extern NSString *const GetUserInfoUrl;  //获取登录状态
extern NSString *const UserLogOutUrl;//退出登录
///上传图片到评论
extern NSString *const UpdataCommentsImagUrl;
///提交评论
FOUNDATION_EXTERN NSString *const CommentsMerchantUrl;

///获取所有店铺
FOUNDATION_EXTERN NSString *const GetAllShopInfo;
///店铺评论
FOUNDATION_EXTERN NSString *const GetAllShopCommentUrl;
///技师评论
FOUNDATION_EXTERN NSString *const GetAllArtificerCommentUrl;

///获取技师
FOUNDATION_EXTERN NSString *const GetRtificersMerchantURL;

///收藏
FOUNDATION_EXTERN NSString *const ColloctMerchantArtificerUrl;

///订单
FOUNDATION_EXTERN NSString *const GetUserOrderUrl;



