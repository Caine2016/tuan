//
//  LoginRequest.m
//  YPTuan
//
//  Created by Caine on 2018/11/12.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

- (NSString *)requestPath {
    
    return self.urlPath;
}


- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

/**
 请求成功的响应类，
 因为需要对请求成功之后的数据做处理，所有才会有这个类，
 名字对应好即可。
 在.h中，我有做了说明，
 如果这个接口只是上传几个参数，
 那么我们无需再写Response的响应处理了，
 将响应的类改为BaseResponse即可。
 */
- (Class)responseClass {
    return [LoginRequest class];
}

@end
