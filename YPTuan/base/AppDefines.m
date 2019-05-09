//
//  AppDefines.m
//  buddhismYDniu
//
//  Created by caine on 2017/9/19.
//  Copyright © 2017年 aolei. All rights reserved.
// vPOST /api/v1/comments/artificer/

#import "AppDefines.h"



#if (ENVIRONMENT == 0)

NSString *const BaseUrl   = @"http://120.79.140.97:8080/api/v1/";

NSString *const UserLogOutUrl  = @"login/logout";
NSString *const UserLoginUrl   = @"login/login"; //登录
NSString *const GetLoginStatus   =  @"login/status/"; //获取登录状态
NSString *const GetUserInfoUrl   =   @"users/account/";///根据username查询用户信息;

NSString *const GetAllShopInfo = @"merchants/";
NSString *const GetAllShopCommentUrl = @"comments/merchant/";
NSString *const GetAllArtificerCommentUrl = @"comments/artificer/";

NSString *const GetRtificersMerchantURL  = @"artificers/merchant/";

NSString *const UpdataCommentsImagUrl = @"comments/images";
NSString *const CommentsMerchantUrl = @"comments/merchant/";

NSString *const ColloctMerchantArtificerUrl = @"collection/";

NSString *const GetUserOrderUrl = @"orders/user/";


#elif (ENVIRONMENT == 1)




#endif


