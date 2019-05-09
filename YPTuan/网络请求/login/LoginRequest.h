//
//  LoginRequest.h
//  YPTuan
//
//  Created by Caine on 2018/11/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "BaseAPIRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginRequest : BaseAPIRequest <APIManager>

@property (nonatomic,strong) NSString *urlPath;

@end

@interface LoginResponse : BaseResponse
//@property(nonatomic,strong)UserModel *data;
@end

NS_ASSUME_NONNULL_END
