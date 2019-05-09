//
//  YLBaseDataService.h
//  YPTuan
//
//  Created by gd on 2018/12/4.
//  Copyright © 2018 Caine. All rights reserved.
//

#import <Foundation/Foundation.h>


#define BaseDataServiceSISingle [YLBaseDataService sharedYLBaseDataService]

NS_ASSUME_NONNULL_BEGIN
@interface YLBaseDataService : NSObject

+(instancetype)sharedYLBaseDataService;


/// del请求字典
-(void)delUrl:(NSString *)url andParamsDic:(NSDictionary *)params andResult:(void (^)(BOOL, BaseResponse * _Nonnull))block;

///post请求字典
-(void)postUrlJoiningTogether:(NSString*)url andParams:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block;

///get请求字典
-(void)getUrl:(NSString*)url andParamsDic:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block;

///get请求字符串
-(void)getUrl:(NSString*)url andParamstr:(NSString*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block;

///post请求
-(void)postUrl:(NSString*)url andParams:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block;


///上传图片
-(void) updataImageToUrl:(NSString*)url andParms:(NSDictionary*)parameterDict andIamgeArr:(NSArray*)imageArr andSuccess:(void(^)(void))success;

- (void)updataImageList:(NSArray *)imageList andUrl:(NSString*)url andParms:(NSDictionary*)parameterDict complection:(void(^)(NSDictionary *results,NSInteger statusCode,NSError *error))block;


@end

NS_ASSUME_NONNULL_END
