//
//  YLCenterVM.m
//  YPTuan
//
//  Created by Caine on 2018/11/18.
//  Copyright © 2018年 Caine. All rights reserved.
//

#import "YLCenterVM.h"

@implementation YLCenterVM

// 获取缓存文件的大小
- (NSString *)readCacheSize{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:cachePath]];
}
// 遍历文件夹获得文件夹大小，返回多少 M
- (float)folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize               = 0 ;
    while ((fileName                   = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath        = [folderPath stringByAppendingPathComponent :fileName];
        folderSize                         += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
}

// 计算 单个文件的大小
- (long long)fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
// 清除缓存
- (void)clearFile{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    //CNSLog ( @"cachpath = %@" , cachePath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];
        }
    }
    
}

-(void)getSettingDataBlock:(void (^)(NSArray * _Nonnull))blockData{
    NSArray* dataArr = @[
                         @{
                             @"title" : @"修改密码",
                             @"imgStr" : @"ChangePwd",
                             
                             },
                       
                         @{
                             @"title" : @"清除缓存",
                             @"imgStr" : @"ClearCache",
                            
                             },
                         @{
                             @"title" : @"用户协议",
                             @"imgStr" : @"UserAgreement",
                             
                             },
                         @{
                             @"title" : @"关于我们",
                             @"imgStr" : @"AboutMe",
                             
                             },
                         @{
                             @"title" : @"意见反馈",
                             @"imgStr" : @"sugToMy",
                             
                             },
                         
                         ];
    
    blockData(dataArr);
}


-(void)getCenterDataBlock:(void (^)(NSArray * _Nonnull))block{
    
    NSArray* dataArr = @[
                         @{
                             @"title" : @"会员中心",
                             @"imgStr" : @"member",
                             
                             },
                         @{
                             @"title" : @"系统消息",
                             @"imgStr" : @"sysNews",
                             
                             },
                         @{
                             @"title" : @"消费记录",
                             @"imgStr" : @"consumption",
                             
                             },
                         @{
                             @"title" : @"商检入驻",
                             @"imgStr" : @"merchantsJoin",
                             
                             },
                   
                         
                         ];
    
    block(dataArr);
    
}

SISingletonM(YLCenterVM)



@end
