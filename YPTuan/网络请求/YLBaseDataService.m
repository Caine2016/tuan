//
//  YLBaseDataService.m
//  YPTuan
//
//  Created by gd on 2018/12/4.
//  Copyright © 2018 Caine. All rights reserved.
//

#import "YLBaseDataService.h"
#import "NSDictionary+YLDicChangeUrl.h"

@implementation YLBaseDataService

SISingletonM(YLBaseDataService)

-(void)postUrl:(NSString*)url andParams:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block{
    
    [BaseAPIProxy sharedInstance].requestSerializer = [AFJSONRequestSerializer serializer]; // 拼接，如果是JSON换成AFJSONRequestSerializer
    [BaseAPIProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
    [[BaseAPIProxy sharedInstance].requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [BaseAPIProxyInstance callAPIWithRequestType:APIManagerRequestTypePost params:params requestPath:GetLoginStatus uploadBlock:^(id<AFMultipartFormData> formData) {
        
        CNSLog(@"%@--GetLoginStatus",formData);
    } success:^(BaseAPIResponse *response) {
        
        CNSLog(@"%@--GetLoginStatus",response.responseData);
       // [data stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
       
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
         BOOL isSuc = [responseData.returnCode isEqualToString:ResponseDataReturnCodeTypeSuccess] ? YES : NO;
        block(isSuc,responseData);
     
        
    } fail:^(BaseAPIResponse *response) {
        
        CNSLog(@"%@--GetLoginStatus11",response.responseData);
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
        block(NO,responseData);
        
    }];
    
    
}

-(void)getUrl:(NSString*)url andParamstr:(NSString*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block{
    
    [BaseAPIProxy sharedInstance].requestSerializer = [AFJSONRequestSerializer serializer]; // 拼接，如果是JSON换成AFJSONRequestSerializer
    [[BaseAPIProxy sharedInstance].requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [BaseAPIProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* paramsURL;
    if (params) {
        paramsURL = [url stringByAppendingString:params];
    }else{
        paramsURL = url;
    }
    
    CNSLog(@"%@--paramsURL",paramsURL);
    
    [BaseAPIProxyInstance callAPIWithRequestType:APIManagerRequestTypeGet params:nil requestPath:paramsURL uploadBlock:^(id<AFMultipartFormData> formData) {
        
        CNSLog(@"%@--GetLoginStatus1",formData);
    } success:^(BaseAPIResponse *response) {
        
        CNSLog(@"%@--GetLoginStatus2",response.responseData);
        // [data stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
        BOOL isSuc = [responseData.returnCode isEqualToString:ResponseDataReturnCodeTypeSuccess] ? YES : NO;
        block(isSuc,responseData);
        
        
    } fail:^(BaseAPIResponse *response) {
        
        CNSLog(@"%@--GetLoginStatus3",response.responseData);
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
        block(NO,responseData);
        
    }];
    
    
}

-(void)delUrl:(NSString *)url andParamsDic:(NSDictionary *)params andResult:(void (^)(BOOL, BaseResponse * _Nonnull))block{
    [self url:url andRequestType:APIManagerRequestTypeDelete andParamsDic:params andResult:^(BOOL suc, BaseResponse * _Nonnull responseData) {
         block(suc,responseData);
    }];
}

-(void)getUrl:( NSString*)url  andParamsDic:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block{
    
    [self url:url andRequestType:APIManagerRequestTypeGet andParamsDic:params andResult:^(BOOL suc, BaseResponse * _Nonnull responseData) {
        block(suc,responseData);
    }];
    
}

-(void)postUrlJoiningTogether:(NSString*)url andParams:(NSDictionary*)params andResult:(void(^)(BOOL succ, BaseResponse* responseData))block{
    
    [self url:url andRequestType:APIManagerRequestTypePost andParamsDic:params andResult:^(BOOL suc, BaseResponse * _Nonnull responseData) {
        block(suc,responseData);
    }];
    
}

-(void)url:(NSString *)url  andRequestType:(APIManagerRequestType)type andParamsDic:(NSDictionary *)params andResult:(void (^)(BOOL, BaseResponse * _Nonnull))block{
    
    [BaseAPIProxy sharedInstance].requestSerializer = [AFJSONRequestSerializer serializer]; // 拼接，如果是JSON换成AFJSONRequestSerializer
    [BaseAPIProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
    
    [[BaseAPIProxy sharedInstance].requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSString* paramsUrl = [params URLRequestStringWithURL:url];
 //   NSString* urlCode = [URLStringCode urlEncodeNullStr:paramsUrl];
    CNSLog(@"%@--paramsUrl",paramsUrl);
    
    [BaseAPIProxyInstance callAPIWithRequestType:type params:nil requestPath:paramsUrl uploadBlock:^(id<AFMultipartFormData> formData) {
        
        CNSLog(@"%@--GetLoginStatus",formData);
    } success:^(BaseAPIResponse *response) {
        
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
        
        CNSLog(@"%@--returnMsg --%@",responseData.returnMsg,responseData.returnCode);
        
        BOOL isSuc = [responseData.returnCode isEqualToString:ResponseDataReturnCodeTypeSuccess] ? YES : NO;

        block(isSuc,responseData);
        
        
    } fail:^(BaseAPIResponse *response) {
        
        CNSLog(@"%@--GetLoginStatus11",response.responseData);
        BaseResponse* responseData = [BaseResponse mj_objectWithKeyValues:response.responseData];
        block(NO,responseData);
        
    }];
    
}


-(void) updataImageToUrl:(NSString*)url andParms:(NSDictionary*)parameterDict andIamgeArr:(NSArray*)imageArr andSuccess:(void(^)(void))success{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",BaseUrl,url] parameters:parameterDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // 这里的_photoArr存放图片的数组
        for (int i = 0; i < imageArr.count; i++) {
            
            UIImage *image = imageArr[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"multipartFiles" fileName:fileName mimeType:@"image/jpeg"]; //
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NLog(@"progress is %@",uploadProgress);
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NLog(@"responseObject = %@",responseObject);
        success();
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
}



- (void)updataImageList:(NSArray *)imageList andUrl:(NSString*)url andParms:(NSDictionary*)parameterDict complection:(void(^)(NSDictionary *results,NSInteger statusCode,NSError *error))block{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString* paramsUrl = [parameterDict URLRequestStringWithURL:url];

    NSURL *updateUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseUrl,paramsUrl]];
   
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:updateUrl];
    [request setTimeoutInterval:60];
    [request setHTTPMethod:@"POST"];
   // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
        NSMutableData *tmpDataM = [NSMutableData new];
        Byte count[] = {(Byte)imageList.count};
        [tmpDataM appendBytes:count length:1];
        
        for (UIImage *tmpImg in imageList) {
            
            
            NSData *data =  UIImageJPEGRepresentation(tmpImg, 1.f);
            
            NSData *tmpData = nil;
            if (data.length > 300000) {
                float fff = 300000.f/data.length;
                ///压缩到300K
                tmpData = UIImageJPEGRepresentation(tmpImg,fff);
            }else{
                tmpData = data;
            }
            Byte length[4] = {(Byte)(tmpData.length),(Byte)(tmpData.length>>8),(Byte)(tmpData.length>>16),(Byte)(tmpData.length>>24)};
            [tmpDataM appendBytes:length length:4];
            [tmpDataM appendData:tmpData];
        }//end for
        [request setHTTPBody:tmpDataM];
    //end else
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        if (error != nil) {
            block(nil,resp.statusCode,error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            return ;
        }
        
        
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //2.解析jsons
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //5.回到主线程
        dispatch_sync(dispatch_get_main_queue(), ^{
            //回调block
            block(result,resp.statusCode,nil);
        });
    }];
    [task resume];
}



@end
