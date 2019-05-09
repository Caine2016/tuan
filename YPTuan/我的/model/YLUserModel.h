//
//  YLUserModel.h
//  YPTuan
//
//  Created by Caine on 2018/11/14.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>


#define UserModelSisingle [YLUserModel sharedYLUserModel]

NS_ASSUME_NONNULL_BEGIN

@interface YLUserModel : NSObject

SISingletonH(YLUserModel)

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *phoneNum;
@property (nonatomic,copy) NSString *cityCode;// 城市名称
@property (nonatomic,copy) NSString *cityName;// 城市名称

@property (nonatomic,copy) NSString *districtCode;//城区编码
@property (nonatomic,copy) NSString *deviceType; //* 设备类型,安卓、苹果
@property (nonatomic,copy) NSString *deviceId; //设备id
@property (nonatomic,copy) NSString *systemVersion;//系统版本
@property (nonatomic,copy) NSString *registerInvitationCode;//注册时所填邀请码
@property (nonatomic,copy) NSString *headPortraitUrl;//头像URL

@property (nonatomic,strong) NSNumber *sex;  //性别：1男、2女
@property (nonatomic,strong) NSNumber *isMember; //是否会员
@property (nonatomic,strong) NSNumber *memberType; //会员类别：1月度会员、2季度会员、3年度会员
@property (nonatomic,strong) NSNumber *memberLevel; //会员等级
@property (nonatomic,strong) NSNumber *memberDaysRemaining; //会员剩余天数
@property (nonatomic,strong) NSNumber *invitationCode; //本人邀请码

///格式化用户数据
- (void)clearData;
@end

NS_ASSUME_NONNULL_END
